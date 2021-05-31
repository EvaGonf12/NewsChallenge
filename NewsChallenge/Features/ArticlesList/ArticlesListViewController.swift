//
//  ArticlesListViewController.swift
//  NewsChallenge
//
//  Created by Eva Gonzalez Ferreira on 30/5/21.
//

import UIKit
import Toast_Swift

class ArticlesListViewController: UIViewController {
    
    // MARK: - Components
    
    private lazy var articlesListView: ArticlesListViewContent = {
        let content = ArticlesListViewContent()
        content.delegate = self
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
    }()
    
    private var searchBarView: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = "Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.showsCancelButton = true
        searchBar.accessibilityIdentifier = "randomUser.searchBar"
        return searchBar
    }()
    
    // MARK: - Init
    var viewModel: ArticlesListViewModel
    
    init(viewModel: ArticlesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        viewModel.viewWasLoaded()
    }
    
    fileprivate func setupView() {
        view.addSubview(articlesListView)
        navigationItem.titleView = searchBarView
        searchBarView.delegate = self
        articlesListView.setup(with: self.viewModel.getListModel())
        
        articlesListView.snp.makeConstraints { make in
            make.edges.equalTo(view.snp.edges)
        }
    }
    
}

// MARK: - ArticlesListViewDelegate
extension ArticlesListViewController: ArticlesListViewDelegate {
    func articlesFetched() {
        articlesListView.reloadData(articles: viewModel.getListModel())
    }
    
    func errorFetchingArticles(error: String) {
        articlesListView.endReload()
        view.makeToast(error, duration: 3.0, position: .bottom)
    }
}

// MARK: - ArticlesListViewContentDelegate
extension ArticlesListViewController: ArticlesListViewContentDelegate {
    func didSelectRow(at: IndexPath) {
        viewModel.didSelectRow(at: at)
    }
    
    func loadMoreArticles() {
        viewModel.loadMoreArticles()
    }
}

// MARK: - UISearchBarDelegate
extension ArticlesListViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
    NSObject.cancelPreviousPerformRequests(withTarget: self,
                                           selector: #selector(filterList),
                                           object: nil)
    perform(#selector(filterList), with: nil, afterDelay: 0.5)
  }
  
  @objc private func filterList() {
    //articlesListView?.filter(by: searchBarView.text ?? "")
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBarView.text = nil
    //listUsersView?.filter(by: "")
    searchBar.resignFirstResponder()
  }
  
  private func dismissKeyboard() {
    self.view.endEditing(true)
  }
}

