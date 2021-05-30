//
//  ServerArticleListToArticlesList.swift
//  NewsChallenge
//
//  Created by Eva Gonzalez Ferreira on 29/5/21.
//

import Foundation

struct ServerArticleListToArticlesList: Mappable {
  
  func map(_ from: ServerArticleList) -> ArticlesList {
    return ArticlesList(apiResponse: from)
  }
}
