//
//  xkcd_iOSFavoriteManagerTests.swift
//  xkcd-iOSTests
//
//  Created by Saori Kurimoto on 2021/11/23.
//

import XCTest
@testable import xkcd_iOS

class xkcd_iOSFavoriteManagerTests: XCTestCase {

    private var userDefaults: UserDefaults!
    private var key = "xkcd_iOSFavoriteManagerTests"
    private var favoriteManager: FavoriteManager!

    override func setUp() {
        userDefaults = UserDefaults(suiteName: #file)
        userDefaults.removePersistentDomain(forName: #file)
        favoriteManager = FavoriteManager(userDefaults: userDefaults, key: key)
    }

    // getFavorites() - Success - nil
     func testGetFavoritesEmptySuccess()  {
         Task {
             do {
                 let favorite = try await favoriteManager.getFavorites()
                 XCTAssertTrue(favorite.isEmpty)

             } catch {
                 XCTFail("should be Success")
             }
         }
    }

    func testGetFavoritesSuccess() async {

        let data = RelevantComic(number: 12, title: "title", titletext: "titletext", url: "url", image: "image", date: "date")

        await self.saveForTest(favorites: [data])
        Task {
            do {
                let favorite = try await favoriteManager.getFavorites()
                XCTAssertTrue(favorite.count == 1)
            } catch {
                XCTFail("should be Success")
            }
        }
   }

    func testAddSuccess() async {
        let data = RelevantComic(number: 12, title: "title", titletext: "titletext", url: "url", image: "image", date: "date")

        Task {
            do {
                let favorite = try await favoriteManager.add(comic: data)
                XCTAssertEqual(favorite.count, 1)
            } catch {
                XCTFail("should be Success")
            }
        }
   }

    func testAddFavoriteDuplicationError() async {
        let data = RelevantComic(number: 12, title: "title", titletext: "titletext", url: "url", image: "image", date: "date")
        await self.saveForTest(favorites: [data])

        Task {
            do {
                let _ = try await favoriteManager.add(comic: data)
                XCTFail("should be Success")
            } catch {
                let e = error as! ComicsError
                XCTAssertEqual(e.rawValue, ComicsError.favoriteDuplication.rawValue)
            }
        }
   }

    func testRemoveSuccess() async {
        let data = [
            RelevantComic(number: 1, title: "title", titletext: "titletext", url: "url", image: "image", date: "date"),
            RelevantComic(number: 2, title: "title", titletext: "titletext", url: "url", image: "image", date: "date"),
            RelevantComic(number: 3, title: "title", titletext: "titletext", url: "url", image: "image", date: "date")
        ]
        let remove = RelevantComic(number: 2, title: "title", titletext: "titletext", url: "url", image: "image", date: "date")

        await saveForTest(favorites: data)

        Task {
            do {
                let favorite = try await favoriteManager.remove(comic: remove)
                XCTAssertFalse(favorite.contains { $0.number == remove.number})
                XCTAssertEqual(favorite.count, 2)

            } catch {
                XCTFail("should be Success")
            }
        }
   }

    private func saveForTest(favorites: [RelevantComic]) async {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            userDefaults.set(encodedFavorites, forKey: key)
        } catch {
            XCTFail("\(error)")
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
