//
//  NewsCoordinator.swift
//  NewsChallenge
//
//  Created by Eva Gonzalez Ferreira on 30/5/21.
//

import UIKit

class NewsCoordinator: Coordinator {

    let presenter: UINavigationController
    let articlesListDataManager: ArticlesListDataManager
    let articleDetailsDataManager: ArticleDetailsDataManager
    var articlesViewModel: ArticlesListViewModel?
    
    init(presenter: UINavigationController,
         articlesListDataManager: ArticlesListDataManager,
         articleDetailsDataManager: ArticleDetailsDataManager) {
        self.presenter = presenter
        self.articlesListDataManager = articlesListDataManager
        self.articleDetailsDataManager = articleDetailsDataManager
    }
    
    override func start() {
        let articlesViewModel = ArticlesListViewModel(dataManager: self.articlesListDataManager)
        let articlesViewController = ArticlesListViewController(viewModel: articlesViewModel)
        articlesViewController.title = NSLocalizedString("Articles", comment: "")
        articlesViewModel.viewDelegate = articlesViewController
        articlesViewModel.coordinatorDelegate = self
        self.articlesViewModel = articlesViewModel
        presenter.pushViewController(articlesViewController, animated: false)
    }

    override func finish() {}
}

extension NewsCoordinator: ArticlesListCoordinatorDelegate {
    func didSelect(article: String) {
//        let favouriteDetailViewModel = FavouriteDetailsViewModel(favId: favourite, favouriteDetailsDataManager: self.favouriteDetailsDataManager)
//        let favouriteDetailViewController = FavouriteDetailViewController(viewModel: favouriteDetailViewModel)
//        favouriteDetailViewController.title = NSLocalizedString("Topic Details", comment: "")
//        favouriteDetailViewModel.viewDelegate = favouriteDetailViewController
//        favouriteDetailViewModel.coordinatorDelegate = self
//        self.presenter.pushViewController(favouriteDetailViewController, animated: true)
    }
}

//extension NewsCoordinator: FavouriteDetailsCoordinatorDelegate {
//
//    func favouriteDetailaBackButtonTapped() {
//        //self.presenter.popViewController(animated: true)
//    }
//}

