//
//  MovieDetail.swift
//  MVVM-RxSwift
//
//  Created by Leonardo  on 23/03/22.
//

import Foundation

struct MovieDetail: Decodable {
  let title: String
  let image: String
  let synopsis: String
  let releaseDate: String
  let homePage: String
  let voteAverage: Double

  enum CodingKeys: String, CodingKey {
    case title
    case image = "poster_path"
    case synopsis = "overview"
    case releaseDate = "release_date"
    case homePage = "homepage"
    case voteAverage = "vote_average"
  }
}
