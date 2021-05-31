//
//  ArticlesListViewModel.swift
//  NewsChallenge
//
//  Created by Eva Gonzalez Ferreira on 30/5/21.
//

import Foundation
import RxSwift

protocol ArticlesListCoordinatorDelegate: AnyObject {
    func didSelect(article: CDArticle)
}

protocol ArticlesListViewDelegate: AnyObject {
    func articlesFetched()
    func errorFetchingArticles(error: String)
}

class ArticlesListViewModel {
    
    let title: String
    weak var coordinatorDelegate: ArticlesListCoordinatorDelegate?
    weak var viewDelegate: ArticlesListViewDelegate?
    private let dataManager: ArticlesListDataManager
    private var articleCellModels: [ArticleCellViewModel]
    private let pageSize: Int
    private var currentPage: Int
    private var querySearch: String
    private var disposeBag = DisposeBag()

    init(dataManager: ArticlesListDataManager) {
        self.dataManager = dataManager
        self.articleCellModels = []
        self.title = "Articles"
        self.pageSize = 5
        self.currentPage = 0
        self.querySearch = ""
    }
    
    func viewWasLoaded() {
//        self.dataManager.clearListArticles()
//        self.dataManager.updateCurrentPage(0)
        self.getArticlesData()
    }
}


// MARK: - Table Data
extension ArticlesListViewModel {
    func getListModel() -> [ArticleCellViewModel] {
        return articleCellModels
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < articleCellModels.count else { return }
        coordinatorDelegate?.didSelect(article: articleCellModels[indexPath.row].article)
    }
    
    func loadMoreArticles() {
        getArticlesData()
    }
    
    fileprivate func getArticlesData() {
        
        currentPage = dataManager.getCurrentPage() + 1
        let filter = FilterListNewsObject(pageSize: "\(self.pageSize)",
                                          page: "\(currentPage)")
        print("CURRENT PAGE", currentPage)
        self.dataManager.fetchArticles(filter: filter)
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] objectArticles in
                
                self?.articleCellModels.removeAll()
                self?.dataManager.saveListArticles(objectArticles.articles)
                self?.dataManager.updateCurrentPage(self?.currentPage ?? 0)

                guard let articles = self?.dataManager.fetchLocalListArticles() else { return }
                self?.createArticlesModels(articles: articles)

            } onError: { [weak self] error in
                if self?.articleCellModels.count == 0 {
                    guard let articles = self?.dataManager.fetchLocalListArticles() else { return }
                    self?.createArticlesModels(articles: articles)
                }                
                self?.viewDelegate?.errorFetchingArticles(error: error.localizedDescription)
            
            } onCompleted: {}.disposed(by: disposeBag)
    }
    
    fileprivate func createArticlesModels(articles: [CDArticle]) {
        
        for article in articles {
            let articleCellModel = ArticleCellViewModel(article: article)
            articleCellModels.append(articleCellModel)
        }
        viewDelegate?.articlesFetched()
    }
}
