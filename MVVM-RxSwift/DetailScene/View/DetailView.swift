//
//  DetailView.swift
//  MVVM-RxSwift
//
//  Created by Leonardo  on 23/03/22.
//

import RxSwift
import UIKit

class DetailView: UIViewController {
  @IBOutlet private weak var movieTitle: UILabel!
  @IBOutlet private weak var movieImage: UIImageView!
  @IBOutlet private weak var movieSynopsis: UILabel!
  @IBOutlet private weak var movieHomePage: UILabel!
  @IBOutlet private weak var movieScore: UILabel!
  @IBOutlet private weak var movieReleaseDate: UILabel!

  private var router = DetailRouter()
  private var viewModel = DetailViewModel()
  private var disposeBag = DisposeBag()

  var movieId: String?

  override func viewDidLoad() {
    print("SECOND")
    super.viewDidLoad()
    viewModel.bind(view: self, router: router)
    displayMovieDetail()
  }

  deinit { print("\(self) deinited") }
}

extension DetailView {
  private func displayMovieDetail() {
    print("display movie detail")
    guard let movieId = movieId else { return }
    return viewModel.getMovieData(movieId: movieId)
      .subscribe(onNext: { [weak self] movie in
        self?.showMovieData(movie: movie)
      }, onError: { error in
        print("Error observer DetailView: \(error)")
      }).disposed(by: disposeBag)
  }

  private func showMovieData(movie: MovieDetail) {
    let imageUrl = "\(Constants.EndPoints.urlImages)\(movie.image)"
    print("image url: \(imageUrl)")
    DispatchQueue.main.async { [weak self] in
      self?.movieTitle.text = movie.title
      self?.movieSynopsis.text = movie.synopsis
      self?.movieReleaseDate.text = movie.releaseDate
      self?.movieImage.imageFromServerURL(urlString: imageUrl, placeholderImage: UIImage(named: "loadingImage.png")!)
      self?.movieHomePage.text = movie.homePage
      self?.movieScore.text = String(movie.voteAverage)
    }
  }
}
