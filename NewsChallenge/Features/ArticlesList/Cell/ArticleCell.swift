//
//  ArticleCellViewController.swift
//  NewsChallenge
//
//  Created by Eva Gonzalez Ferreira on 30/5/21.
//

import UIKit

final class ArticleCell: UITableViewCell {
    
    private var model: ArticleCellViewModel?
    
    private lazy var cellView: ArticleCellView = {
        return ArticleCellView()
    }()
        
    func setup(with model: ArticleCellViewModel) {
        self.model = model
        setupView()
        setupConstraints()
        cellView.setup(with: model)
    }
    
    private func setupView() {
        addSubview(cellView)
    }
    
    private func setupConstraints() {
        cellView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

