//
//  ArticlesListViewModel.swift
//  NewsChallenge
//
//  Created by Eva Gonzalez Ferreira on 30/5/21.
//

import Foundation
import RxSwift

protocol ArticlesListCoordinatorDelegate: AnyObject {
    func didSelect(article: String)
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
    private var listViewModels: [String]
    private let pageSize: Int
    private var currentPage: Int
    private var querySearch: String
    private var disposeBag = DisposeBag()

    init(dataManager: ArticlesListDataManager) {
        self.dataManager = dataManager
        self.listViewModels = []
        self.title = "Articles"
        self.pageSize = 20
        self.currentPage = 1
        self.querySearch = ""
    }
    
    func viewWasLoaded() {
        // TODO: obtener datos de las listas
        self.getArticlesData()
    }
    
}


// MARK: - Table Data
extension ArticlesListViewModel {
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return listViewModels.count
    }
    
    func viewModel(at indexPath: IndexPath) -> String? {
        guard indexPath.row < listViewModels.count else { return nil }
        return listViewModels[indexPath.row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < listViewModels.count else { return }
        coordinatorDelegate?.didSelect(article: listViewModels[indexPath.row])
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
                    self?.listViewModels.removeAll()
                }
                self?.dataManager.saveListArticles(objectArticles.articles)
                let articles = self?.dataManager.fetchLocalListArticles()
                print(articles?.count)
//                for fav in listViewModels {
//                    let favCell = FavouriteCellViewModel(favourite: fav)
//                    self?.favViewModels.append(favCell)
//                }
                self?.viewDelegate?.articlesFetched()
                
            } onError: { [weak self] error in
                self?.viewDelegate?.errorFetchingArticles(error: error.localizedDescription)
            
            } onCompleted: {}.disposed(by: disposeBag)
    }
}
