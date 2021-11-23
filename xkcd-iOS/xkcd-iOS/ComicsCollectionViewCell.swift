//
//  ComicsCollectionViewCell.swift
//  xkcd-iOS
//
//  Created by Saori Kurimoto on 2021/11/22.
//

import UIKit

class ComicsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: NetworkImageView!

    func configureCell(_ comic: RelevantComic) {
        imageView.downloadImage(fromURL: comic.image)
    }

}
