//
//  LocalNewsChallengeDataManager.swift
//  NewsChallenge
//
//  Created by Eva Gonzalez Ferreira on 29/5/21.
//

import Foundation

final class LocalNewsChallengeDataManagerImp: LocalNewsChallengeDataManager {
    
    var coreDataStorage = LocalDataBase(databaseName: "Model")
    var localStorage: LocalStorageService = UserDefaultsLocalStorage(userDefaults: UserDefaults.standard)
    
    func fetchNews() -> [CDArticle] {
        let articles = coreDataStorage.fetchArticlesData() ?? []
        return articles
    }
    
    func filterNews(with filter: String) -> [CDArticle] {
        let articles = coreDataStorage.fetchArticlesData(with: filter) ?? []
        return articles
    }
    
    func saveNews(_ articles: [Article]) {
        coreDataStorage.saveArticles(articles)
    }
    
    func fetchPageList() -> Int {
        let page = localStorage.integer(forKey: .currentPage)
        return page
    }
    
    func savePageList(_ page: Int) {
        localStorage.store(value: page, forKey: .currentPage)
    }
    
    func clearList() {
        localStorage.store(value: 1, forKey: .currentPage)
        coreDataStorage.clear()
    }
}
