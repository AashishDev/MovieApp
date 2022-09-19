//
//  MovieSearchViewModel.swift
//  MovieApp
//
//  Created by Aashish Tyagi on 9/19/22.
//

import Foundation

class MovieSearchViewModel: ObservableObject {
    
    private let service:MovieSearchServiceProtocol
    var completion:(([Movie]) -> Void)?
    
    init(service:MovieSearchServiceProtocol =  MovieSearchService())
    {
        self.service =  service
    }
    
    func searchMovieByName(name:String) {
        Task.init {
            if let response = await searchMovie(query: name) {
                DispatchQueue.main.async { [weak self] in 
                    self?.completion?(response.movies)
                }
            }
        }
    }
    
    private func searchMovie(query:String) async -> MovieResponse? {
        do {
            let response = try await self.service.searchMovieByName(query: query)
            return response
        }
        catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
