//
//  ArticleCoreData.swift
//  NewsChallenge
//
//  Created by Eva Gonzalez Ferreira on 29/5/21.
//

import Foundation

protocol ArticleCoreData {
    var entity: CoreDataEntity { get }
    func fetchArticlesData(with query: String) -> [CDArticle]?
    func fetchArticlesData() -> [CDArticle]?
    func saveArticles(_ articles: [Article])
}
