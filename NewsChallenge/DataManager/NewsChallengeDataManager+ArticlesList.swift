//
//  NewsChallengeDataManager+ArticlesList.swift
//  NewsChallenge
//
//  Created by Eva Gonzalez Ferreira on 30/5/21.
//

import Foundation
import RxSwift

extension NewsChallengeDataManager: ArticlesListDataManager {
    
    func fetchArticles(filter: FilterListNewsObject) -> (Observable<ArticlesList>) {
        return self.remoteDataManager.fetchNews(filterNewsObject: filter)
    }
        
    func saveListArticles(_ articles: [Article]) {
        self.localDataManager.saveNews(articles)
    }
    
    func fetchLocalListArticles(with filter: String) -> [CDArticle] {
        let articles = self.localDataManager.fetchNews()
        return articles
    }
    
    func fetchLocalListArticles() -> [CDArticle] {
        return self.localDataManager.fetchNews()
    }
    
    func clearListArticles() {
        self.localDataManager.clearList()
    }
    
}
