//
//  MovieCell.swift
//  MVVM-RxSwift
//
//  Created by Leonardo  on 21/03/22.
//

import UIKit

class MovieCell: UITableViewCell {
  @IBOutlet private weak var movieTitle: UILabel!
  @IBOutlet private weak var movieSynopsis: UILabel!
  @IBOutlet private weak var movieImage: UIImageView!

  var movie: Movie? {
    didSet {
      configureCell()
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}

extension MovieCell {
  private func configureCell() {
    guard let movie = self.movie else { return }
    let imageUrl = "\(Constants.EndPoints.urlImages)\(movie.image)"
    movieTitle.text = movie.title
    movieSynopsis.text = movie.synopsis
    movieImage.imageFromServerURL(urlString: imageUrl, placeholderImage: UIImage(named: "loadingImage.png")!)
  }
}
