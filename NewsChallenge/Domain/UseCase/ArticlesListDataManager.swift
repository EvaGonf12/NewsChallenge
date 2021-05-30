//
//  ArticlesListDataManager.swift
//  NewsChallenge
//
//  Created by Eva Gonzalez Ferreira on 30/5/21.
//

import Foundation
import RxSwift

protocol ArticlesListDataManager: AnyObject {
    /// Fetch articles from server
    func fetchArticles(filter: FilterListNewsObject) -> (Observable<ArticlesList>)
    
    /// Save articles in Local Data Base
    func saveListArticles(_ articles: [Article])
    
    /// Fetch local filtered articles
    func fetchLocalListArticles(with filter: String) -> [CDArticle]
    
    /// Fetch all local articles
    func fetchLocalListArticles() -> [CDArticle]
    
    /// Remove Local Articles
    func clearListArticles()
}
