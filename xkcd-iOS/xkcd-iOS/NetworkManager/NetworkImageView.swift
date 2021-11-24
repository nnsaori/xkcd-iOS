//
//  NetworkImageView.swift
//  xkcd-iOS
//
//  Created by Saori Kurimoto on 2021/11/23.
//

import UIKit

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

        Task {
            do {
                let favorites = try await FavoriteManager().getFavorites().compactMap { $0 }
                if let comics = favorites.filter({ $0.image == url }).first, let imageData = comics.comicImage {
                    image = UIImage(data: imageData)
                } else {
                    image = await NetworkManager.shared.downloadImage(from: url) ?? placeholderImage
                }
            } catch {
            }
        }
    }
}
