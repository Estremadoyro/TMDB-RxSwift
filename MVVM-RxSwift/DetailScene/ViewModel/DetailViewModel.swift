//
//  DetailViewModel.swift
//  MVVM-RxSwift
//
//  Created by Leonardo  on 23/03/22.
//

import Foundation
import RxSwift

class DetailViewModel {
  private var managerConnections = ManagerConnections()
  private weak var view: DetailView?
  private weak var router: DetailRouter?

  func bind(view: DetailView, router: DetailRouter) {
    self.view = view
    self.router = router
    self.router?.setSourceView(view)
  }

  func getMovieData(movieId: String) -> Observable<MovieDetail> {
    return managerConnections.getDetailMovie(movieId: movieId)
  }
}
