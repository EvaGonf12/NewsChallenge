//
//  AppCoordinator.swift
//  NewsChallenge
//
//  Created by Eva Gonzalez Ferreira on 30/5/21.
//

import UIKit

class AppCoordinator: Coordinator {
    let sessionAPI = SessionAPI()
    
    // Remote Data Manager
    lazy var remoteDataManager: RemoteNewsChallengeDataManager = {
        let remoteDataManager = RemoteNewsChallengeDataManagerImp(session: sessionAPI)
        return remoteDataManager
    }()
    
    // Local Data Manager
    lazy var localDataManager: LocalNewsChallengeDataManager = {
        let localDataManager = LocalNewsChallengeDataManagerImp()
        return localDataManager
    }()
    
    // Data Manager
    lazy var dataManager: NewsChallengeDataManager = {
        let dataManager = NewsChallengeDataManager(localDataManager: self.localDataManager,
                                                   remoteDataManager: self.remoteDataManager)
        return dataManager
    }()
    
    // Window
    let window: UIWindow
    init(window: UIWindow) {
        self.window = window
    }
    
    // ----------- INICIO -----------
    override func start() {
        let newsViewController = UINavigationController()
        newsViewController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        newsViewController.navigationBar.tintColor = UIColor.black
        let newsCoordinator = NewsCoordinator(presenter: newsViewController,
                                              articlesListDataManager: dataManager,
                                              articleDetailsDataManager: dataManager)
        addChildCoordinator(newsCoordinator)
        newsCoordinator.start()
         
        window.rootViewController = newsViewController
        window.makeKeyAndVisible()
    }
    
}

