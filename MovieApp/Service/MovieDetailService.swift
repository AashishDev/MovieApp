//
//  MovieDetailService.swift
//  MovieApp
//
//  Created by Aashish Tyagi on 9/18/22.
//

import Foundation
import Networking


struct MovieDetail:Codable {
    let id:Int
    let title:String
    let poster_path:String
    let overview:String
    //Release date  "release_date":"2022-07-06",
    
    var postImageUrl:URL {
        let basePath = "https://image.tmdb.org/t/p/w500"
        return URL(string: basePath + poster_path)!
    }
}

protocol MovieDetailServiceProtocol {
    func getMovieDetail(movieId:Int) async throws -> MovieDetail
}

struct MovieDetailService:MovieDetailServiceProtocol {
    private let apiManager:APIServiceProtocol
    init(apiManager:APIServiceProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
    func getMovieDetail(movieId:Int) async throws -> MovieDetail {
        return try await withCheckedThrowingContinuation { continuation in
            
            self.apiManager.execute(responseType: MovieDetail.self, endpoint: .MovieDetail(id: movieId)) { result in
                continuation.resume(with: result)
            }
        }
    }
}
