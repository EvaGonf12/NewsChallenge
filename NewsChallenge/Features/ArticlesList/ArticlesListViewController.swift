//
//  ArticlesListViewController.swift
//  NewsChallenge
//
//  Created by Eva Gonzalez Ferreira on 30/5/21.
//

import UIKit

class ArticlesListViewController: UIViewController {
    
    // MARK: - Components
    
    var articlesListView: ArticlesListView?
    
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
        view = articlesListView
        //articlesListView?.delegate = self
        navigationItem.titleView = searchBarView
        searchBarView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        viewModel.viewWasLoaded()
    }
}

// MARK: - ArticlesListViewDelegate
extension ArticlesListViewController: ArticlesListViewDelegate {
    func articlesFetched() {
        
    }
    
    func errorFetchingArticles(error: String) {
        
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
