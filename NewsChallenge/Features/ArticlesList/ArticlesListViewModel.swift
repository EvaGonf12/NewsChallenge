//
//  ArticlesListViewModel.swift
//  NewsChallenge
//
//  Created by Eva Gonzalez Ferreira on 30/5/21.
//

import Foundation
import RxSwift

protocol ArticlesListCoordinatorDelegate: AnyObject {
    func didSelect(article: ArticleCellViewModel)
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
        self.currentPage = 1
        self.querySearch = ""
    }
    
    func viewWasLoaded() {
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
        coordinatorDelegate?.didSelect(article: articleCellModels[indexPath.row])
    }
    
    fileprivate func getArticlesData() {
        print("getArticlesData")
        let filter = FilterListNewsObject(pageSize: "\(self.pageSize)",
                                          page: "\(self.currentPage)")
        self.dataManager.clearListArticles()
        self.dataManager.fetchArticles(filter: filter)
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] objectArticles in
                if self?.currentPage == 1 {
                    //self?.dataManager.clearListArticles()
                    self?.articleCellModels.removeAll()
                }
                self?.dataManager.saveListArticles(objectArticles.articles)
                guard let articles = self?.dataManager.fetchLocalListArticles() else { return }
                print(articles.count)
                for article in articles {
                    let articleCellModel = ArticleCellViewModel(article: article)
                    self?.articleCellModels.append(articleCellModel)
                }
                self?.viewDelegate?.articlesFetched()
            } onError: { [weak self] error in
                self?.viewDelegate?.errorFetchingArticles(error: error.localizedDescription)
            
            } onCompleted: {}.disposed(by: disposeBag)
    }
}
