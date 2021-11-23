//
//  ComicsError.swift
//  xkcd-iOS
//
//  Created by Saori Kurimoto on 2021/11/22.
//


enum ComicsError: String, Error {
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
}
