//
//  HomeView.swift
//  MVVM-RxSwift
//
//  Created by Leonardo  on 21/03/22.
//

import RxCocoa
import RxSwift
import UIKit

enum CellKeys: String {
  case nibName = "MovieCell"
  case reuseIdentifier = "Cell"
}

class HomeVC: UIViewController {
  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var activity: UIActivityIndicatorView!
//  private var searchController: UISearchController!

  private var router = HomeRouter()
  private var viewModel = HomeViewModel()

  private var disposeBag = DisposeBag()

  private var movies = [Movie]()
  private var filteredMovies = [Movie]()

  lazy var searchController = SearchController()

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
    configureVC()
    displayMovies()
  }
}

extension HomeVC {
  private func configureVC() {
    configureBindings()
    configureNavBar()
    configureTableView()
    configureSearchController()
  }

  private func configureNavBar() {
    navigationItem.title = "Home"
  }

  private func configureTableView() {
    let nibName = CellKeys.nibName.rawValue
    let reuseIdentifier = CellKeys.reuseIdentifier.rawValue
    tableView.rowHeight = UITableView.automaticDimension
    tableView.register(UINib(nibName: nibName, bundle: Bundle.main), forCellReuseIdentifier: reuseIdentifier)
  }

  private func configureBindings() {
    viewModel.bind(view: self, router: router)
  }

  private func configureSearchController() {
    let searchBar = searchController.searchBar
    searchBar.delegate = self
    navigationItem.searchController = searchController
//    tableView.tableHeaderView = searchBar
//    tableView.contentOffset = CGPoint(x: 0, y: searchBar.frame.size.height)

    searchBar.rx.text
      .orEmpty
      .distinctUntilChanged()
      // When the text of the search bar gets updated
      .subscribe(onNext: { [weak self] result in
        guard let strongSelf = self else { return }
        print("Updated searchbar to: \(result)")
        strongSelf.filteredMovies = strongSelf.movies.filter { movie in
          strongSelf.updateTableView()
          return movie.title.contains(result)
        }
      }).disposed(by: disposeBag)
  }
}

extension HomeVC {
  private func displayMovies() {
    return viewModel.getMoviesList()
      // Handle RxSwift concurrency, execute on Main Thread
      .subscribe(on: MainScheduler.instance)
      .observe(on: MainScheduler.instance)
      // Subscribe observer to Observable
      .subscribe(
        onNext: { [weak self] movies in
          self?.movies = movies
          print("movies in view: \(movies.map { $0.originalTitle })")
          self?.updateTableView()
        }, onError: { error in
          print("error in view: \(error)")
          // Finalize the RxSwift sequence (Disposable)
        }, onCompleted: {}).disposed(by: disposeBag)
  }
}

extension HomeVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if searchController.isActive, searchController.searchBar.text != "" {
      return filteredMovies.count
    }
    return movies.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellIdentifier: String = CellKeys.reuseIdentifier.rawValue
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MovieCell else {
      fatalError("Error dequing cell: \(cellIdentifier)")
    }
    var movie = movies[indexPath.row]
    if searchController.isActive, searchController.searchBar.text != "" {
      movie = filteredMovies[indexPath.row]
    }
    cell.movie = movie
    return cell
  }
}

extension HomeVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 200
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    var movie = movies[indexPath.row]
    if searchController.isActive, searchController.searchBar.text != "" {
      movie = filteredMovies[indexPath.row]
    }
//    tableView.tableHeaderView = nil
    router.naviagteToDetailView(movieId: String(movie.movieId))
  }
}

extension HomeVC {
  private func updateTableView() {
    DispatchQueue.main.async { [weak self] in
      self?.tableView.reloadData()
      self?.activity.stopAnimating()
      self?.activity.isHidden = true
    }
  }
}

extension HomeVC: UISearchBarDelegate {
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//    searchController.isActive = false
    print("Filtered movies: \(filteredMovies.map { $0.title })")
    guard movies.count == filteredMovies.count else { return  }
    updateTableView()
  }
}
