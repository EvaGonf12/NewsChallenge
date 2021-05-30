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
    
    func fetchNews(filterNewsObject: FilterListNewsObject) -> [CDArticle] {
        let articles = coreDataStorage.fetchArticlesData(with: filterNewsObject.qInTitle) ?? []
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
}
