//
//  ArticleCellViewModel.swift
//  NewsChallenge
//
//  Created by Eva Gonzalez Ferreira on 30/5/21.
//

import Foundation

struct ArticleCellViewModel  {
    
    let article: CDArticle
    let image: URL?
    let title: String?
    let description: String?
    
    init(article: CDArticle) {
        self.article = article
        self.title = article.title
        self.description = article.resume
        self.image = URL(string: article.image ?? "")
    }
}
