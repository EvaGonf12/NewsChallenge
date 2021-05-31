//
//  ArticleDetailsViewModel.swift
//  NewsChallenge
//
//  Created by Eva Gonzalez Ferreira on 31/5/21.
//

import Foundation

protocol ArticleDetailsCoordinatorDelegate: AnyObject {
    func articleDetailsBackButtonTapped()
}

protocol ArticleDetailsViewDelegate: AnyObject {}

class ArticleDetailsViewModel {
    
    weak var coordinatorDelegate: ArticleDetailsCoordinatorDelegate?
    weak var viewDelegate: ArticleDetailsViewDelegate?
    
    let image: URL?
    let date: Date?
    let title: String?
    let content: String?
    
    init(article: CDArticle) {
        image = URL(string: article.image ?? "")
        title = article.title
        content = article.content
        date = article.date
    }
    
    func backButtonTapped() {
        coordinatorDelegate?.articleDetailsBackButtonTapped()
    }
}
