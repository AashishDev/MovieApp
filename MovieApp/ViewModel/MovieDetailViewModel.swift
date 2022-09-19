//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by Aashish Tyagi on 9/18/22.
//

import Foundation

class MovieDetailViewModel: ObservableObject {
    
   private let service:MovieDetailServiceProtocol
    var completion:((MovieDetail) -> Void)?
    
    init(service:MovieDetailServiceProtocol =  MovieDetailService())
    {
        self.service =  service
    }
    
    func getSelectedMovieDetails(movieId:Int) {
        Task.init {
            if let movieDetail = await getMovieDetail(movieId: movieId) {
                DispatchQueue.main.async { [weak self] in
                    self?.completion?(movieDetail)
                }
            }
        }
    }
    
    private func getMovieDetail(movieId:Int) async -> MovieDetail? {
        do {
            let response = try await self.service.getMovieDetail(movieId: movieId)
            return response
        }
        catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
