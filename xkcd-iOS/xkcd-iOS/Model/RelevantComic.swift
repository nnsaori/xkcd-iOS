//
//  RelevantComic.swift
//  xkcd-iOS
//
//  Created by Saori Kurimoto on 2021/11/22.
//

import Foundation

struct RelevantComic: Codable {    // relevant-xkcd-backend.herokuapp.com Response
    let number: Int
    let title: String
    let titletext: String
    let url: String
    let image: String
    let date: String
}

