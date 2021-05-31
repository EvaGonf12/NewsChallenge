//
//  ArticleDetailsViewController.swift
//  NewsChallenge
//
//  Created by Eva Gonzalez Ferreira on 31/5/21.
//

import UIKit
import SnapKit
import Kingfisher

private enum ViewLayout {
    static let imageHeight = 300.0
    static let spacing = Spacing.xxs
    static let mainFont = Font.main
    static let secondaryFont = Font.secondary
    static let horizontalSpacing = Spacing.s
}

class ArticleDetailsViewController: UIViewController {
    
    // MARK: - Components
    
    private lazy var contentScrollView: UIView = {
        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.backgroundColor = .white
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.font = ViewLayout.secondaryFont
        label.numberOfLines = 0
        label.textColor = .darkGray
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
    
    
    // MARK: - Init
    
    let viewModel: ArticleDetailsViewModel

    init(viewModel: ArticleDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupContraints()
        fillData()
    }
    
    fileprivate func setupView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentScrollView)
        contentScrollView.addSubview(articleImageView)
        contentScrollView.addSubview(titleLabel)
        contentScrollView.addSubview(dateLabel)
        contentScrollView.addSubview(descriptionLabel)
        
        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        leftBarButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    fileprivate func setupContraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        contentScrollView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top)
            make.bottom.equalTo(scrollView.snp.bottom)
            make.width.equalTo(scrollView.snp.width)
        }
        
        articleImageView.snp.makeConstraints { make in
            make.top.equalTo(contentScrollView.snp.top)
            make.leading.equalTo(contentScrollView.snp.leading)
            make.trailing.equalTo(contentScrollView.snp.trailing)
            make.height.equalTo(ViewLayout.imageHeight)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(articleImageView.snp.bottom).offset(ViewLayout.spacing)
            make.leading.equalTo(contentScrollView.snp.leading).offset(ViewLayout.horizontalSpacing)
            make.trailing.equalTo(contentScrollView.snp.trailing).offset(-ViewLayout.horizontalSpacing)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(ViewLayout.spacing)
            make.leading.equalTo(contentScrollView.snp.leading).offset(ViewLayout.horizontalSpacing)
            make.trailing.equalTo(contentScrollView.snp.trailing).offset(-ViewLayout.horizontalSpacing)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(ViewLayout.spacing)
            make.leading.equalTo(contentScrollView.snp.leading).offset(ViewLayout.horizontalSpacing)
            make.trailing.equalTo(contentScrollView.snp.trailing).offset(-ViewLayout.horizontalSpacing)
            make.bottom.equalTo(contentScrollView.snp.bottom)
        }
    }
    
    fileprivate func fillData() {
        articleImageView.kf.setImage(with: viewModel.image)
        dateLabel.text = viewModel.date?.toString()
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.content
    }
    
    @objc func backButtonTapped() {
        viewModel.backButtonTapped()
    }
    
}

extension ArticleDetailsViewController: ArticleDetailsViewDelegate {}
