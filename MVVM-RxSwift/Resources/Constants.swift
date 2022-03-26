//
//  Constants.swift
//  MVVM-RxSwift
//
//  Created by Leonardo  on 21/03/22.
//

import Foundation

// https://api.themoviedb.org/3/movie/popular?api_key=070fd999c946b0f734ad2cb151c99fcb
enum Constants {
  static let apiKey = Keys.apiKey
  static let apiVersion = "3/"

  enum URL {
    static let host = "api.themoviedb.org"
    static let scheme = "https"
  }

  enum EndPoints {
    static let urlListMovies = "/3/movie/popular"
    static let urlDetailMovie = "/3/movie/"
    static let urlImages = "https://image.tmdb.org/t/p/w200"
  }
}
