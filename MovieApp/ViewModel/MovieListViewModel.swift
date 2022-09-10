//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Aashish Tyagi on 9/9/22.
//

import Foundation

class MovieListViewModel {
    let service:MovieServiceProtocol
    var moviesList:[[Movie]] = []
    var dataChanged:(() -> Void)?

    init(service:MovieServiceProtocol =  MovieService()) {
        self.service =  service
        loadNowPlayingMovies()
        }
    
    
    //TODO: API Call in Parallell
    func loadNowPlayingMovies() {
        
        let movieList = "https://api.themoviedb.org/3/movie/now_playing?api_key=11c5d3b2a72c53e38a4b740b08d28921&language=en-US&page=1"
        self.service.loadMovies(path: movieList) { result in
            
            switch result {
            case .success(let movieResponse):
                self.moviesList.append(movieResponse.movies)
                self.loadPopularMovies()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadPopularMovies() {
        
        let movieList = "https://api.themoviedb.org/3/movie/popular?api_key=11c5d3b2a72c53e38a4b740b08d28921&language=en-US&page=2"
        self.service.loadMovies(path: movieList) { result in
            
            switch result {
            case .success(let movieResponse):
                self.moviesList.append(movieResponse.movies)
                self.loadUpComingMovies()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func loadUpComingMovies() {
        
        let movieList = "https://api.themoviedb.org/3/movie/upcoming?api_key=11c5d3b2a72c53e38a4b740b08d28921&language=en-US&page=2"
        self.service.loadMovies(path: movieList) { result in
            
            switch result {
            case .success(let movieResponse):
                self.moviesList.append(movieResponse.movies)
                
                print("Final Response - \n \(self.moviesList)")
                
                
                DispatchQueue.main.async {
                    self.dataChanged?()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
}
