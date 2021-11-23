//
//  SearchTableViewCell.swift
//  xkcd-iOS
//
//  Created by Saori Kurimoto on 2021/11/22.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var comicView: NetworkImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {

        super.awakeFromNib()
        comicView.contentMode = .scaleAspectFill
        comicView.clipsToBounds = true
    }

    func configureCell(comic: RelevantComic?) {
        guard let comic = comic else {
            return
        }

        comicView.downloadImage(fromURL: comic.image)
        idLabel.text = "#\(comic.number)"
        titleLabel.text = "\(comic.title)"
    }

}
