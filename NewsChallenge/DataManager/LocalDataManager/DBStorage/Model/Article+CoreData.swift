//
//  Article+CoreData.swift
//  NewsChallenge
//
//  Created by Eva Gonzalez Ferreira on 29/5/21.
//

import CoreData

extension CDArticle {
    @discardableResult
    convenience init(article: Article, context: NSManagedObjectContext) {
      self.init(context: context)
        image = article.image
        title = article.title
        littleDescription = article.description
        resume = article.resume
        date = article.date
    }
}

extension CDArticle {
  var toArticle: Article {
    return Article(image: image,
                   title: title,
                   resume: resume,
                   description: littleDescription,
                   date: date)
  }
}
