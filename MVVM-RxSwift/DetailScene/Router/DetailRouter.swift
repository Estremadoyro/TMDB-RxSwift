//
//  DetailRouter.swift
//  MVVM-RxSwift
//
//  Created by Leonardo  on 23/03/22.
//

import UIKit

class DetailRouter {
  private weak var sourceView: UIViewController?
  var movieId: String?

  init(movieId: String = "") {
    self.movieId = movieId
  }
}

extension DetailRouter {
  func setSourceView(_ sourceView: UIViewController?) {
    guard let view = sourceView else { return }
    self.sourceView = view
  }

  func createViewController(movieId: String) -> UIViewController {
    let vc = DetailView(nibName: "DetailView", bundle: Bundle.main)
    vc.movieId = movieId
    return vc
  }
}
