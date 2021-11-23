//
//  NetworkManager.swift
//  xkcd-iOS
//
//  Created by Saori Kurimoto on 2021/11/22.
//

import UIKit

class NetworkManager {
    static let shared  = NetworkManager()
    let decoder = JSONDecoder()

    let cache = NSCache<NSString, UIImage>()
    var session: URLSession


    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        session = URLSession.shared
    }

    func getCurrentComics() async throws -> XkcdComic? {
        let (data, response) = try await session.data(from: Environment.currentComicUrl)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ComicsError.invalidResponse
        }

        do {
            return try decoder.decode(XkcdComic.self, from: data)
        } catch {
            throw ComicsError.invalidResponse
        }
    }

    func getComics(keyword: String?) async throws -> RelevantComicResponse? {

        var request = URLRequest(url: Environment.searchComicUrl)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        if let keyword = keyword, keyword.isEmpty == false {
                let post = "search=\(keyword)"
                let postData = post.data(using: String.Encoding.ascii, allowLossyConversion: true)!
                request.httpBody = postData
            }

        let (data, response) = try await session.data(for: request)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ComicsError.invalidResponse
        }

//        let resultData = String(data: data, encoding: .utf8)!
//        print(resultData)

        do {
            return try decoder.decode(RelevantComicResponse.self, from: data)
        } catch {
            throw ComicsError.invalidResponse
        }
    }


    func downloadImage(from urlString: String) async -> UIImage? {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) { return image }
        guard let url = URL(string: urlString) else { return nil }

        do {
            let (data, _) = try await session.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            return nil
        }
    }
}
