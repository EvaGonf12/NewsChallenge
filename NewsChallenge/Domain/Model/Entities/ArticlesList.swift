//
//  ArticlesList.swift
//  NewsChallenge
//
//  Created by Eva Gonzalez Ferreira on 29/5/21.
//

import Foundation

struct ArticlesList {
    let totalResults: Int
    let articles: [Article]
    
    init(apiResponse: ServerArticleList) {
        articles = apiResponse.articles?.compactMap { Article(apiResponse: $0) } ?? []
        totalResults = apiResponse.totalResults ?? 0
    }
}
