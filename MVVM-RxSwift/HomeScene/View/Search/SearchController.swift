//
//  SearchVC.swift
//  MVVM-RxSwift
//
//  Created by Leonardo  on 22/03/22.
//

import UIKit

class SearchController: UISearchController {
  init() {
    super.init(searchResultsController: nil)
    configureSearchController()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension SearchController {
  func configureSearchController() {
    hidesNavigationBarDuringPresentation = true
//    obscuresBackgroundDuringPresentation = true
    searchBar.sizeToFit()
    searchBar.barStyle = .default
    searchBar.backgroundColor = UIColor.clear
    searchBar.placeholder = "Search from class"
  }
}
