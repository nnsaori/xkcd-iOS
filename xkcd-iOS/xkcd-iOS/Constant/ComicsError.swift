//
//  ComicsError.swift
//  xkcd-iOS
//
//  Created by Saori Kurimoto on 2021/11/22.
//


enum ComicsError: String, Error {
    case invalidResponse = "Invalid response from the server. Please try again."
    case favoriteFailed = "There was an error favorites failed. Please try again."
    case favoriteDuplication = "You've already favorited."
}
