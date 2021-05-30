//
//  ArticleCellViewModel.swift
//  NewsChallenge
//
//  Created by Eva Gonzalez Ferreira on 30/5/21.
//

import Foundation

struct ArticleCellViewModel  {
    
    let image: URL?
    let title: String?
    let description: String?
    
    init(article: CDArticle) {
        self.title = article.title
        self.description = article.littleDescription
        self.image = URL(string: article.image ?? "")
    }
}
