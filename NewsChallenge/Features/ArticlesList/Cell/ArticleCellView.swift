//
//  ArticleCellView.swift
//  NewsChallenge
//
//  Created by Eva Gonzalez Ferreira on 30/5/21.
//

import UIKit
import SnapKit
import Kingfisher

private enum ViewLayout {
    static let imageHeight = 300.0
    static let spacing = Spacing.xxs
    static let mainFont = Font.main
    static let secondaryFont = Font.secondary
}

final class ArticleCellView: UIView {
 
    private lazy var articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
      let label = UILabel()
      label.textAlignment = .natural
      label.font = ViewLayout.mainFont
      label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
      return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.font = ViewLayout.secondaryFont
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [articleImageView, titleLabel, descriptionLabel])
        stack.axis = .vertical
        stack.spacing = ViewLayout.spacing
        stack.distribution = .fill
        stack.alignment = .top
        stack.translatesAutoresizingMaskIntoConstraints = true
        return stack
    }()
    
    func setup(with model: ArticleCellViewModel) {
        setupView()
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        articleImageView.kf.setImage(with: model.image)
    }
    
    fileprivate func setupView() {
        setupArticleImage()
        addSubview(mainStack)
        mainStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(ViewLayout.spacing)
            make.leading.equalToSuperview().offset(ViewLayout.spacing)
            make.trailing.equalToSuperview().offset(-ViewLayout.spacing)
            make.bottom.equalToSuperview().offset(-ViewLayout.spacing)
        }
    }
    
    private func setupArticleImage() {
        articleImageView.snp.makeConstraints { make in
            make.height.equalTo(ViewLayout.imageHeight)
        }
    }
    
}

