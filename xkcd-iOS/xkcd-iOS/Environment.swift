//
//  Environment.swift
//  xkcd-iOS
//
//  Created by Saori Kurimoto on 2021/11/22.
//

import UIKit

class Environment: NSObject {
    static let comicUrl = "https://xkcd.com"
    static let currentComicUrl = "\(comicUrl)/info.0.json"
    static let searchComicUrl = "https://relevant-xkcd-backend.herokuapp.com/search"
    static let detailWebUrl = "https://www.explainxkcd.com/wiki/index.php"
}
