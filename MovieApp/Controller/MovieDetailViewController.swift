//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Aashish Tyagi on 9/8/22.
//
import UIKit

class MovieDetailViewController: UIViewController,Storyboardable {
    static var storyboardName: StoryBoard = .MovieDetail

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    private let vm = MovieDetailViewModel()
    var movie:Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = movie!.title
        self.navigationItem.largeTitleDisplayMode = .never
        fetchMovieDetails()
    }
    
    fileprivate func fetchMovieDetails() {
        vm.completion = { movieDetail in
            DispatchQueue.main.async { [weak self] in
                self?.movieImageView.loadImage(with: movieDetail.postImageUrl)
                self?.titleLabel.text = movieDetail.overview
            }
        }
        vm.getSelectedMovieDetails(movieId: movie!.id)
    }
}
