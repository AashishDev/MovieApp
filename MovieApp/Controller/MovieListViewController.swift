//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by Aashish Tyagi on 9/8/22.
//

import UIKit


enum MovieType:String,CaseIterable {
    case NowPlaying = "Now Playing"
    case Popular
    case UpComing = "Up Coming"
}


class MovieListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let vm = MovieListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Movie List"
        tableView.register(UITableViewCell.self
                           , forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = .black
        vm.dataChanged = { [weak self] in
            self?.tableView.reloadData()
        }
        
    }
}


extension MovieListViewController:UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        MovieType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return MovieType.allCases[section].rawValue
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel!.font = UIFont.boldSystemFont(ofSize: 19)
            header.textLabel!.textColor = UIColor.white
            header.contentView.backgroundColor = UIColor.black
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier:MovieListTableViewCell.identifier, for: indexPath) as? MovieListTableViewCell else {
            return UITableViewCell()
        }
        
        if vm.moviesList.count > 2 {
            cell.configure(with: vm.moviesList[indexPath.section],indexPath: indexPath)
        }
     
        cell.backgroundColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 270
        }
        else if indexPath.section == 1 {
            return 230
        }
        return 250
    }
}


