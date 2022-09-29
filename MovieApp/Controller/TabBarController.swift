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
        var childControllers:[UINavigationController] = []
        let storyBoard = UIStoryboard(name: "Main", bundle: .main)
        
        // 1 Home
        if let movieListVC = storyBoard.instantiateViewController(
            withIdentifier: "MovieListViewController") as? MovieListViewController {
            let navigation =  UINavigationController(rootViewController: movieListVC)
            navigation.tabBarItem.title = "Home"
            navigation.tabBarItem.image = UIImage(systemName: "house.fill")
            childControllers.append(navigation)
            
            movieListVC.didSelectItem = { [weak self] movie in
                self?.moveToDetailScreen(movie: movie, from: movieListVC)
            }
        }
        
        // 2 Search
        if let searchVC = storyBoard.instantiateViewController(
            withIdentifier: "SearchMovieViewController") as? SearchMovieViewController {
            
            let navigation =  UINavigationController(rootViewController: searchVC)
            navigation.navigationItem.largeTitleDisplayMode = .always
            navigation.navigationBar.largeContentTitle = "Search"
            navigation.tabBarItem.title = "Search"
            navigation.tabBarItem.image = UIImage(systemName: "magnifyingglass")
            childControllers.append(navigation)
            
            searchVC.didSelectItem = { [weak self] movie in
                self?.moveToDetailScreen(movie: movie, from: searchVC)
            }
        }
        
        viewControllers =  childControllers
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






