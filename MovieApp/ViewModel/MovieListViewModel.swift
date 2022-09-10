//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Aashish Tyagi on 9/9/22.
//

import Foundation
import Combine

class MovieListViewModel: ObservableObject {
    let service:MovieServiceProtocol
    
    @Published private(set) var moviesList:[[Movie]] = []
    //var dataChanged:(() -> Void)?
    
    init(service:MovieServiceProtocol =  MovieService()) {
        self.service =  service
        loadAllMovies()
    }
    
    public func loadAllMovies() {
        Task.init {
            let movies = await loadMovies()
            DispatchQueue.main.async {
                self.moviesList = movies
            }
        }
    }
    func loadMovies() async  -> [[Movie]]  {
        //- https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html
        async let nowPlayingMovies = nowPlaying()
        async let popularMovies =   popular()
        async let upcomingMovies =  upcoming()

        let movies: [[Movie]] = await [nowPlayingMovies,popularMovies,upcomingMovies]
        return movies
    }
    
    
    //TODO: API Call in Parallell
    func nowPlaying(pageNo:Int = 1) async -> [Movie] {
        do {
            let response = try await self.service.loadMovies(endpoint: .NowPlaying(pageNo: pageNo))
            return response.movies
        }
        catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    func popular(pageNo:Int = 1) async -> [Movie]  {
        do {
            let response = try await self.service.loadMovies(endpoint: .Popular(pageNo: pageNo))
            return response.movies
        }
        catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    func upcoming(pageNo:Int = 1) async -> [Movie]  {
        do {
            let response = try await self.service.loadMovies(endpoint: .UpComing(pageNo: pageNo))
            return response.movies
        }
        catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    
    /*
    func loadNowPlayingMovies() {
        
        self.service.loadMovies(endpoint: .NowPlaying(pageNo: 1)) { result in
            switch result {
            case .success(let movieResponse):
                self.moviesList.append(movieResponse.movies)
                print("Now Playing Response - \n \(self.moviesList)")

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadPopularMovies() {
        
        self.service.loadMovies(endpoint: .Popular(pageNo: 1)) { result in
            switch result {
            case .success(let movieResponse):
                self.moviesList.append(movieResponse.movies)
                print("Popular Response - \n \(self.moviesList)")

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func loadUpComingMovies() {
        
        self.service.loadMovies(endpoint: .UpComing(pageNo: 1)) { result in
            switch result {
            case .success(let movieResponse):
                self.moviesList.append(movieResponse.movies)
                print("UPComing Response - \n \(self.moviesList)")

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }*/
}


extension MovieListViewModel {
    
    func numberOfRow(section:Int) -> Int {
        return moviesList[section].count
    }
    
    func numberOfSection() -> Int {
        return moviesList.count
    }
    
    func itemsForSection(section:Int) -> [Movie]{
        return moviesList[section]
    }
}
