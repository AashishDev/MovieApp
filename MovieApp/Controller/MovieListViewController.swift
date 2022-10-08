//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by Aashish Tyagi on 9/8/22.
//

import UIKit
import Combine

enum MovieType: String, CaseIterable {
    case nowPlaying = "Now Playing"
    case popular
    case upComing = "Up Coming"
}

class MovieListViewController: UITableViewController {
    private let vm = MovieListViewModel()
    private var cancellable: AnyCancellable?
    private var tableDataArray:[[Movie]] = []
    static var nowPlayingCurrentPage = 0
    static var popularCurrentPage = 0
    static var upcomingCurrentPage = 0
    
    var didSelectItem:((Movie) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self
                           , forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = .black
        
        reloadTableForNewMovies()
        view.showLoading()
        vm.refreshAllMovieListing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar(largeTitleColor: .white, backgoundColor: .black, tintColor: .white, title: "Movies", preferredLargeTitle: true)
    }
    
    private func reloadTableForNewMovies() {
        cancellable = vm.$moviesList.sink { [weak self] movies in
            self?.tableDataArray = movies

            DispatchQueue.main.async {
                self?.view.stopLoading()
                self?.tableView.reloadData()
                self?.refreshControl?.endRefreshing()
            }
        }
    }
    
    @IBAction func refreshControlValueChanged(_ sender: UIRefreshControl) {
        view.showLoading()
        vm.refreshAllMovieListing()
    }
}

extension MovieListViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        tableDataArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return MovieType.allCases[section].rawValue
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel!.font = UIFont.boldSystemFont(ofSize: 19)
            header.textLabel!.textColor = UIColor.white
            header.contentView.backgroundColor = UIColor.black
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0.0
    }
    
    override  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(
            withIdentifier:MovieListTableViewCell.identifier,
            for: indexPath) as? MovieListTableViewCell else {
            return UITableViewCell()
        }
        
        let selMovies =  tableDataArray[indexPath.section]
        cell.configure(with: selMovies, indexPath: indexPath)
        let type = MovieType.allCases[indexPath.section]
        cell.loadMore = {
            
            switch type {
            case .nowPlaying:
                let nextPage =  MovieListViewController.nowPlayingCurrentPage + 1
                self.vm.loadMoreForNowPlayingList(pageNo: nextPage)
                MovieListViewController.nowPlayingCurrentPage = nextPage
                
            case .popular:
                let nextPage =  MovieListViewController.popularCurrentPage + 1
                self.vm.loadMoreForPopularList(pageNo: nextPage)
                MovieListViewController.popularCurrentPage = nextPage
                
            case .upComing:
                let nextPage =  MovieListViewController.upcomingCurrentPage + 1
                self.vm.loadMoreForUpcomingList(pageNo: nextPage)
                MovieListViewController.upcomingCurrentPage = nextPage
            }
        }
        cell.selectedItem = didSelectItem
        cell.backgroundColor = .white
        return cell
    }
    
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 270
        } else if indexPath.section == 1 {
            return 230
        }
        return 250
    }
}



