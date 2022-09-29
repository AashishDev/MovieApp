//
//  SearchViewController.swift
//  MovieApp
//
//  Created by Aashish Tyagi on 9/8/22.
//

import UIKit
import Combine

class SearchMovieViewController: UIViewController {
    
    private let vm = MovieSearchViewModel()
    private var filteredMovies:[Movie] = []
    @IBOutlet weak var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    private var cancellable: AnyCancellable?

    var didSelectItem:((Movie) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search"
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search movies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        vm.completion = { movies in
            self.filteredMovies =  movies
            self.tableView.reloadData()
        }
    }
}

extension SearchMovieViewController:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(
            withIdentifier:SearchTableViewCell.identifier,
            for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = self.filteredMovies[indexPath.row]
        cell.configure(with: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = self.filteredMovies[indexPath.row]
        didSelectItem?(movie)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


extension SearchMovieViewController:UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        cancellable = searchController.searchBar.publisher(for: \.text)
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .sink { value in
                if let _value = value {
                    let searchText = _value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    self.vm.searchMovieByName(name: searchText ?? "")
                }
            }
    }
}
