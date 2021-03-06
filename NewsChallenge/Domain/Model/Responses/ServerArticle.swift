//
//  ServerArticle.swift
//  NewsChallenge
//
//  Created by Eva Gonzalez Ferreira on 29/5/21.
//

import Foundation

struct ServerArticle: Codable {
    //let source: ServerSource?
    //let author: String?
    //let url: String?
    let title: String?
    let description: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    enum CodingKeys: String, CodingKey {
        //case source
        //case author
        //case url
        case title
        case description
        case urlToImage
        case publishedAt
        case content
    }
}
