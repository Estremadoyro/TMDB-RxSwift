//
//  HomeViewModel.swift
//  MVVM-RxSwift
//
//  Created by Leonardo  on 21/03/22.
//

import Foundation
import RxSwift

class HomeViewModel {
  private weak var view: HomeVC?
  private weak var router: HomeRouter?
  private let managerConnections = ManagerConnections()

  func bind(view: HomeVC, router: HomeRouter) {
    self.view = view
    self.router = router
    self.router?.setSourceView(view)
  }

  func getMoviesList() -> Observable<[Movie]> {
    return managerConnections.getPopularMovies()
  }
  
  func showDetailView(movieId: String) {
    router?.naviagteToDetailView(movieId: movieId)
  }
}
