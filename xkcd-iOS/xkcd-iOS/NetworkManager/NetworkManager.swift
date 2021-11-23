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


    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }

    func getCurrentComics() async throws -> XkcdComic? {
        let endpoint = Environment.currentComicUrl

        guard let url = URL(string: endpoint) else {
            throw ComicsError.invalidUrl
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ComicsError.invalidResponse
        }

        do {
            return try decoder.decode(XkcdComic.self, from: data)
        } catch {
            throw ComicsError.invalidData
        }
    }

    func getComics(keyword: String?) async throws -> RelevantComicResponse? {
        let endpoint = Environment.searchComicUrl

        guard let url = URL(string: endpoint) else {
            throw ComicsError.invalidUrl
        }

        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        if let keyword = keyword, keyword.isEmpty == false {
                let post = "search=\(keyword)"
                let postData = post.data(using: String.Encoding.ascii, allowLossyConversion: true)!
                request.httpBody = postData
            }

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ComicsError.invalidResponse
        }

//        let resultData = String(data: data, encoding: .utf8)!
//        print(resultData)

        do {
            return try decoder.decode(RelevantComicResponse.self, from: data)
        } catch {
            throw ComicsError.invalidData
        }
    }


    func downloadImage(from urlString: String) async -> UIImage? {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) { return image }
        guard let url = URL(string: urlString) else { return nil }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            return nil
        }
    }
}

class NetworkImageView: UIImageView {

    var placeholderImage: UIImage {
        let image = UIImage()
        image.withTintColor(.systemGray)
        return image
    }

    func downloadImage(fromURL url: String?) {
        guard let url = url else {
            return
        }

        Task { image = await NetworkManager.shared.downloadImage(from: url) ?? placeholderImage }
    }
}
