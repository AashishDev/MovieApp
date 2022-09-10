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
    
    init(service:MovieServiceProtocol =  MovieService()) {
        self.service =  service
        loadAllMovies()
    }
    
    public func loadAllMovies() {
        self.moviesList.removeAll()
        Task.init {
            let movies = await loadMovies()
            DispatchQueue.main.async {
                self.moviesList = movies
            }
        }
    }
    
    func loadMovies() async  -> [[Movie]]  {
        //return [await nowPlaying()]
        async let nowPlayingMovies = nowPlaying()
        async let popularMovies =   popular()
        async let upcomingMovies =  upcoming()
        return await [nowPlayingMovies,popularMovies,upcomingMovies]
    }
    
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
    
    
    func loadMoreForNowPlayingList(pageNo:Int) {
        Task {
            let result = await nowPlaying(pageNo: pageNo)
            moviesList[0].append(contentsOf: result)
            print("NowPlaying loadMore")
        }
    }
    
    func loadMoreForPopularList(pageNo:Int) {
        Task {
            let result =  await popular(pageNo: pageNo)
            moviesList[1].append(contentsOf: result)
            print("PopPular loadMore")
        }
    }
    
    func loadMoreForUpcomingList(pageNo:Int) {
        Task {
            let result =   await upcoming(pageNo: pageNo)
            moviesList[2].append(contentsOf: result)
            print("UpComing loadMore")
        }
    }
    
}
