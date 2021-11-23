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

        Task { image = await NetworkManager.shared.downloadImage(from: url) ?? placeholderImage }
    }
}
