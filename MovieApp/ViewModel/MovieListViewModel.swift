//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Aashish Tyagi on 9/9/22.
//

import Foundation
import Combine

class MovieListViewModel: ObservableObject {
    let nowPlayingService:MovieServiceProtocol
    let popularService:MovieServiceProtocol
    let upcomingService:MovieServiceProtocol
    
    @Published private(set) var moviesList:[[Movie]] = []
    
    init(nowPlaying:MovieServiceProtocol =  NowPlayingMovieService(),
         popular:MovieServiceProtocol =  PopularMovieService(),
         upComing:MovieServiceProtocol =  UpComingMovieService())
    {
        self.nowPlayingService =  nowPlaying
        self.popularService =  popular
        self.upcomingService =  upComing
    }
    
    public func refreshAllMovieListing() {
        Task {
            let movies = await loadAllMovies()
            DispatchQueue.main.async {
                self.moviesList = movies
            }
        }
    }
}

//Public Methods ----------------------------------------
extension MovieListViewModel {
    
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


extension MovieListViewModel {
    
    func loadAllMovies() async  -> [[Movie]]  {
        async let nowPlayingMovies = nowPlaying()
        async let popularMovies =  popular()
        async let upComingMovies =  upcoming()
        return await [nowPlayingMovies,popularMovies,upComingMovies]
    }
    
    private func nowPlaying(pageNo:Int = 1) async -> [Movie] {
        await getMovies(service: nowPlayingService, pageNo: pageNo)
    }
    
    private func popular(pageNo:Int = 1) async -> [Movie]  {
        await getMovies(service: popularService, pageNo: pageNo)
    }
    
    private func upcoming(pageNo:Int = 1) async -> [Movie]  {
        await getMovies(service: upcomingService, pageNo: pageNo)
    }
    
    private func getMovies(service:MovieServiceProtocol,pageNo:Int) async -> [Movie]{
        do {
            let response = try await self.upcomingService.loadMovies(pageNo: pageNo)
            return response.movies
        }
        catch {
            print(error.localizedDescription)
        }
        return []
    }
}
