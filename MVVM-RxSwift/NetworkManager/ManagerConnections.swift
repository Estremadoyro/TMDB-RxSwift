//
//  ManagerConnections.swift
//  MVVM-RxSwift
//
//  Created by Leonardo  on 21/03/22.
//

import Foundation
import RxSwift

class ManagerConnections {
  // Create Observable objects
  // https://api.themoviedb.org/3/movie/popular?api_key=070fd999c946b0f734ad2cb151c99fcb
  func getPopularMovies() -> Observable<[Movie]> {
    return Observable.create { observer in
      NetworkRequest.makeNetworkRequest(path: Constants.EndPoints.urlListMovies) { (completion: RequestCompletionType<Movies>) in
        switch completion {
          case .requestSuccessful(data: let data):
            observer.onNext(data.moviesList)
          case .requestEnded:
            observer.onCompleted()
          case .requestFailure(let error):
            observer.onError(error)
        }
      }
      return Disposables.create()
    }
  }

  func getDetailMovie(movieId: String) -> Observable<MovieDetail> {
    let path: String = "\(Constants.EndPoints.urlDetailMovie)\(movieId)"
    return Observable.create { observer in
      NetworkRequest.makeNetworkRequest(path: path) { (completion: RequestCompletionType<MovieDetail>) in
        switch completion {
          case .requestSuccessful(data: let data):
            observer.onNext(data)
          case .requestEnded:
            observer.onCompleted()
          case .requestFailure(let error):
            observer.onError(error)
        }
      }
      return Disposables.create()
    }
  }
}
