//
//  xkcd_iOSNetworkManagerTests.swift
//  xkcd-iOSTests
//
//  Created by Saori Kurimoto on 2021/11/22.
//

import XCTest
@testable import xkcd_iOS

class xkcd_iOSNetworkManagerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // getCurrentComics() - Success
    func testGetCurrentComicsSuccess() async throws {
        MockURLProtocol.requestHandler = {request in
            let mockData = MockResponse.currentComicSuccessMockData.data(using: .utf8)!
            let response = HTTPURLResponse.init(url: request.url!, statusCode: 200, httpVersion: "2.0", headerFields: nil)!
            return (response, mockData)
        }

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)

        let net = NetworkManager.shared
        net.session = urlSession

        Task {
            do {
                let comic = try await net.getCurrentComics()
                XCTAssertNotNil(comic)
            } catch {
                XCTFail("should be Success")
            }
        }
    }

    // getCurrentComics() - Error statusCode 500
    func testGetCurrentComicsStatusCodeError() async throws {
        MockURLProtocol.requestHandler = {request in
            let mockData = MockResponse.currentComicSuccessMockData.data(using: .utf8)!
            let response = HTTPURLResponse.init(url: request.url!, statusCode: 500, httpVersion: "2.0", headerFields: nil)!
            return (response, mockData)
        }

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)

        let net = NetworkManager.shared
        net.session = urlSession

        Task {
            do {
                let _ = try await net.getCurrentComics()
            } catch {
                let e = error as! ComicsError
                XCTAssertEqual(e.rawValue, ComicsError.invalidResponse.rawValue)
            }
        }
    }

    // getCurrentComics() - Error decode faild
    func testGetCurrentComicsDecoderror() async throws {
        MockURLProtocol.requestHandler = {request in
            let mockData = MockResponse.searchComicSuccessMockData.data(using: .utf8)!
            let response = HTTPURLResponse.init(url: request.url!, statusCode: 200, httpVersion: "2.0", headerFields: nil)!
            return (response, mockData)
        }

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)

        let net = NetworkManager.shared
        net.session = urlSession

        Task {
            do {
                let _ = try await net.getCurrentComics()
            } catch {
                let e = error as! ComicsError
                XCTAssertEqual(e.rawValue, ComicsError.invalidResponse.rawValue)
            }
        }
    }

    // getComics(keyword) - Success
    func testSearchComicSuccess() async throws {
        MockURLProtocol.requestHandler = {request in
            let mockData = MockResponse.searchComicSuccessMockData.data(using: .utf8)!
            let response = HTTPURLResponse.init(url: request.url!, statusCode: 200, httpVersion: "2.0", headerFields: nil)!
            return (response, mockData)
        }

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)

        let net = NetworkManager.shared
        net.session = urlSession

        Task {
            do {
                let comics = try await net.getComics(keyword: "test")
                XCTAssertGreaterThan(comics!.results.count, 1)
            } catch {
                XCTFail("should be Success")
            }
        }
    }

    // getComics(keyword) - Error statusCode 500
    func testSearchComicStatusCodeError() async throws {
        MockURLProtocol.requestHandler = {request in
            let mockData = MockResponse.searchComicSuccessMockData.data(using: .utf8)!
            let response = HTTPURLResponse.init(url: request.url!, statusCode: 500, httpVersion: "2.0", headerFields: nil)!
            return (response, mockData)
        }

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)

        let net = NetworkManager.shared
        net.session = urlSession

        Task {
            do {
                let _ = try await net.getComics(keyword: "test")
            } catch {

                let e = error as! ComicsError
                XCTAssertEqual(e.rawValue, ComicsError.invalidResponse.rawValue)
            }
        }
    }

    // getComics(keyword) - Error decode faild
    func testSearchComicDecoderror() async throws {
        MockURLProtocol.requestHandler = {request in
            let mockData = MockResponse.currentComicSuccessMockData.data(using: .utf8)!
            let response = HTTPURLResponse.init(url: request.url!, statusCode: 200, httpVersion: "2.0", headerFields: nil)!
            return (response, mockData)
        }

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)

        let net = NetworkManager.shared
        net.session = urlSession

        Task {
            do {
                let _ = try await net.getComics(keyword: "test")
            } catch {
                let e = error as! ComicsError
                XCTAssertEqual(e.rawValue, ComicsError.invalidResponse.rawValue)
            }
        }
    }
}
