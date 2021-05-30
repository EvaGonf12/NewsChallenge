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
    
    init(presenter: UINavigationController,
         articlesListDataManager: ArticlesListDataManager,
         articleDetailsDataManager: ArticleDetailsDataManager) {
        self.presenter = presenter
        self.articlesListDataManager = articlesListDataManager
        self.articleDetailsDataManager = articleDetailsDataManager
    }
    
    override func start() {
//        let favouritesViewModel = FavouritesViewModel(favouritesDataManager: favouritesDataManager)
//        let favouritesViewController = FavouritesViewController(viewModel: favouritesViewModel)
//        favouritesViewController.title = NSLocalizedString("Favourites", comment: "")
//        favouritesViewModel.viewDelegate = favouritesViewController
//        favouritesViewModel.coordinatorDelegate = self
//        self.favouritesViewModel = favouritesViewModel
//        presenter.pushViewController(favouritesViewController, animated: false)
    }

    override func finish() {}
}
//
//extension NewsCoordinator: FavouritesCoordinatorDelegate {
//    func didSelect(favourite: String) {
//        let favouriteDetailViewModel = FavouriteDetailsViewModel(favId: favourite, favouriteDetailsDataManager: self.favouriteDetailsDataManager)
//        let favouriteDetailViewController = FavouriteDetailViewController(viewModel: favouriteDetailViewModel)
//        favouriteDetailViewController.title = NSLocalizedString("Topic Details", comment: "")
//        favouriteDetailViewModel.viewDelegate = favouriteDetailViewController
//        favouriteDetailViewModel.coordinatorDelegate = self
//        self.presenter.pushViewController(favouriteDetailViewController, animated: true)
//    }
//}
//
//extension NewsCoordinator: FavouriteDetailsCoordinatorDelegate {
//
//    func favouriteDetailaBackButtonTapped() {
//        self.presenter.popViewController(animated: true)
//    }
//}

