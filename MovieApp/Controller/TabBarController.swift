//
//  TabBarController.swift
//  MovieApp
//
//  Created by Aashish Tyagi on 9/8/22.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        setUp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUp()
    }
    
    private func setUp() {
       let storyBoard = UIStoryboard(name: "Main", bundle: .main)
        
        //Home
        guard let movieListVC = storyBoard.instantiateViewController(
            withIdentifier: "MovieListViewController") as? MovieListViewController else { return }
        movieListVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        movieListVC.didSelectItem = { [weak self] movie in
            self?.moveToDetailScreen(movie: movie, from: movieListVC)
        }
        
        //Search
        guard let searchVC = storyBoard.instantiateViewController(
            withIdentifier: "SearchMovieViewController") as? SearchMovieViewController else { return }
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        searchVC.didSelectItem = { [weak self] movie in
            self?.moveToDetailScreen(movie: movie, from: searchVC)
        }
        
        let childControllers = [movieListVC,searchVC]
        viewControllers =  childControllers.map({ UINavigationController.init(rootViewController: $0) })
    }
   
    // 3 Detail Screen
    private func moveToDetailScreen(movie:Movie, from viewController:UIViewController) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailVc = storyBoard.instantiateViewController(
            withIdentifier: "MovieDetailViewController") as? MovieDetailViewController
        else { return }
        detailVc.movie = movie
        detailVc.hidesBottomBarWhenPushed = true
        viewController.showDetailViewController(detailVc, sender: viewController)
    }
}






