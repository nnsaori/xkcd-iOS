//
//  FavoriteManager.swift
//  xkcd-iOS
//
//  Created by Saori Kurimoto on 2021/11/23.
//

import Foundation

class FavoriteManager {
    private let defaults: UserDefaults!
    private let favoriteManagerKey: String!

    init(userDefaults: UserDefaults = UserDefaults.standard, key: String = "favorites") {
        self.defaults = userDefaults
        favoriteManagerKey = key
    }

    func getFavorites() async throws -> [RelevantComic?] {
        guard let favoritesData = defaults.object(forKey: favoriteManagerKey) as? Data else {
            return []
        }

        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([RelevantComic].self, from: favoritesData)
            return favorites
        } catch {
            throw ComicsError.favoriteFailed
        }
    }

    func add(comic: RelevantComic) async throws -> [RelevantComic] {
        do {
            let result = try await getFavorites()
            var favorites = result.compactMap{ $0 }

            if favorites.contains(where: { $0.number == comic.number }) {
                throw ComicsError.favoriteDuplication // already favorited error
            }
            var newComic = comic
            let image = await NetworkManager.shared.downloadImage(from: comic.image)
            newComic.comicImage = image?.jpegData(compressionQuality: 1.0)
            favorites.append(newComic)

            try await self.save(favorites: favorites)
            return favorites

        } catch {
            throw error
        }
    }

    func remove(comic: RelevantComic) async throws -> [RelevantComic] {
        do {
            let result = try await getFavorites()
            var favorites = result.compactMap{ $0 }

            favorites.removeAll { $0.number == comic.number }

            try await save(favorites: favorites)
            return favorites

        } catch {
            throw error
        }
    }

    private func save(favorites: [RelevantComic]) async throws {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: favoriteManagerKey)
        } catch {
            throw ComicsError.favoriteFailed
        }
    }
}
