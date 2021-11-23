//
//  RelevantComicResponse.swift
//  xkcd-iOS
//
//  Created by Saori Kurimoto on 2021/11/22.
//

import Foundation

class RelevantComicResponse: Codable {
    let success: Bool
    let message: String
    let results: [RelevantComic]
}
