//
//  Environment.swift
//  xkcd-iOS
//
//  Created by Saori Kurimoto on 2021/11/22.
//

import UIKit

class Environment: NSObject {
    static let comicUrlString = "https://xkcd.com"
    static let currentComicUrlString = "\(comicUrlString)/info.0.json"
    static let searchComicUrlString = "https://relevant-xkcd-backend.herokuapp.com/search"
    static let detailWebUrlString = "https://www.explainxkcd.com/wiki/index.php"

    static let currentComicUrl = URL(string: currentComicUrlString)!
    static let searchComicUrl = URL(string: searchComicUrlString)!
}
