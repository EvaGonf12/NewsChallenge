//
//  Article.swift
//  NewsChallenge
//
//  Created by Eva Gonzalez Ferreira on 29/5/21.
//

import Foundation

struct Article {
    let image: String
    let title: String
    let resume: String
    let description: String
    let date: Date?
    
    init(apiResponse: ServerArticle) {
        self.image = apiResponse.urlToImage ?? ""
        self.title = apiResponse.title ?? ""
        self.resume = apiResponse.description ?? ""
        self.description = apiResponse.content ?? ""
        self.date = apiResponse.publishedAt?.toDate()
    }
    
    init(image: String?,
         title: String?,
         resume: String?,
         description: String?,
         date: Date?) {
        
        self.image = image ?? ""
        self.title = title ?? ""
        self.resume = resume ?? ""
        self.description = description ?? ""
        self.date = date
    }
}
