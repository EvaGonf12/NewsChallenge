//
//  ArticlesListView.swift
//  NewsChallenge
//
//  Created by Eva Gonzalez Ferreira on 30/5/21.
//

import UIKit

private enum ViewLayout {
    static let cellHeight = 150.0
}

protocol ArticlesListViewContentDelegate: AnyObject {
    func didSelectRow(at: IndexPath)
    func loadMoreArticles()
}

final class ArticlesListViewContent: UIView  {
    
    // MARK: - Components
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(ArticleCell.self, forCellReuseIdentifier: "ArticleCell")
        table.backgroundColor = .clear
        table.estimatedRowHeight = CGFloat(ViewLayout.cellHeight)
        table.rowHeight = UITableView.automaticDimension
        table.layer.borderWidth = 0
        table.separatorStyle = .none
        return table
    }()
    
    var viewModel: [ArticleCellViewModel]?
    weak var delegate: ArticlesListViewContentDelegate?
    
    func setup(with model: [ArticleCellViewModel]) {
        self.viewModel = model
        setupView()
    }
    
    func reloadData(articles: [ArticleCellViewModel]) {
        self.viewModel = articles
        tableView.reloadData()
        endReload()
    }
    
    func endReload() {
        tableView.endUpdates()
        tableView.finishInfiniteScroll()
    }
    
    private func setupView() {
        self.backgroundColor = .white
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        tableView.addInfiniteScroll { [weak self] _ in
            self?.tableView.beginUpdates()
            self?.delegate?.loadMoreArticles()
        }
    }
}

// MARK: - UITableViewDataSource
extension ArticlesListViewContent:  UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.count ?? 0
    }
    
    fileprivate func viewModel(at indexPath: IndexPath) -> ArticleCellViewModel? {
        guard indexPath.row < viewModel?.count ?? 0 else { return nil }
        return viewModel?[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? ArticleCell,
           let cellViewModel = viewModel(at: indexPath) {
            cell.setup(with: cellViewModel)
            return cell
        }
        fatalError()
    }
}

// MARK: - UITableViewDelegate

extension ArticlesListViewContent:  UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelectRow(at: indexPath)
    }
}
