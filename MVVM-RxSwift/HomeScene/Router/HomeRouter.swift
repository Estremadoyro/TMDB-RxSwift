//
//  HomeRouter.swift
//  MVVM-RxSwift
//
//  Created by Leonardo  on 21/03/22.
//

import UIKit

// Creates the Home object and handles navigation across views
class HomeRouter {
  private weak var sourceView: UIViewController?
}

extension HomeRouter {
  func setSourceView(_ sourceView: UIViewController?) {
    guard let view = sourceView else { fatalError("Error setting source view") }
    self.sourceView = view
  }

  func naviagteToDetailView(movieId: String) {
    let detailView = DetailRouter(movieId: movieId).createViewController(movieId: movieId)
    sourceView?.navigationController?.pushViewController(detailView, animated: true)
  }
}
