//
//  NetworkRequest.swift
//  MVVM-RxSwift
//
//  Created by Leonardo  on 23/03/22.
//

import Foundation

enum RequestCompletionType<T> {
  case requestSuccessful(data: T)
  case requestFailure(error: Error)
  case requestEnded
}

enum NetworkRequest {
  static func makeNetworkRequest<T: Decodable>(path: String, requestCompleted: @escaping (RequestCompletionType<T>) -> Void) {
    // Observable.create (_ subscribe @escaping AnyObserver<[Movie]> -> Disposable) -> Observer<[Movie]>
    // Creates the observable, returns Observable<[Movie]>
    // Inside, returns the Disposable from the closure parameter
    var urlBuilder = URLComponents()
    urlBuilder.scheme = Constants.URL.scheme
    urlBuilder.host = Constants.URL.host
    urlBuilder.path = path
    urlBuilder.queryItems = [
      URLQueryItem(name: "api_key", value: Constants.apiKey)
    ]
    print("URL TO FETCH FROM: \(urlBuilder.url)")
    guard let url = urlBuilder.url else {
      fatalError("getPopularMovies failed to decode url: \(urlBuilder.string ?? "")")
    }

    print("URL to fetch from: \(url)")

    let session = URLSession.shared
    session.dataTask(with: url) { data, response, error in
      guard let data = data, let response = response as? HTTPURLResponse, error == nil else { return }
      guard response.statusCode == 200 else {
        print("Error, response code is NOT 200")
        return
      }
      do {
        let data = try JSONDecoder().decode(T.self, from: data)
        /// # Setting `Observer`'s value
        requestCompleted(.requestSuccessful(data: data))
      } catch {
        requestCompleted(.requestFailure(error: error))
        print("Error decoding: \(error)")
      }
      requestCompleted(.requestEnded)
    }.resume()
    session.finishTasksAndInvalidate()
  }
}
