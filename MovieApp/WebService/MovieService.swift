//
//  MovieService.swift
//  MovieApp
//
//  Created by Aashish Tyagi on 9/9/22.
//

import Foundation

struct Movie:Codable {
    let id:Int
    let title:String
    let poster_path:String
    
    var postImageUrl:URL {
        let basePath = "https://image.tmdb.org/t/p/w500"
        return URL(string: basePath + poster_path)!
    }
}

struct MovieResponse:Codable {
    let page:Int
    let movies:[Movie]
    
    private enum CodingKeys : String, CodingKey {
        case page
        case movies = "results"
    }
}

protocol MovieServiceProtocol {
    func loadMovies(pageNo:Int) async throws -> MovieResponse
}

struct NowPlayingMovieService:MovieServiceProtocol {
    private let apiManager:APIServiceProtocol
    init(apiManager:APIServiceProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
    func loadMovies(pageNo:Int) async throws -> MovieResponse {
        return try await withCheckedThrowingContinuation { continuation in
            self.apiManager.execute(responseType: MovieResponse.self, endpoint: .NowPlaying(pageNo: pageNo)) { result in
                continuation.resume(with: result)
            }
        }
    }
}

struct PopularMovieService:MovieServiceProtocol {
    private let apiManager:APIServiceProtocol
    init(apiManager:APIServiceProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
    func loadMovies(pageNo:Int) async throws -> MovieResponse {
        return try await withCheckedThrowingContinuation { continuation in
            self.apiManager.execute(responseType: MovieResponse.self, endpoint: .Popular(pageNo: pageNo)) { result in
                continuation.resume(with: result)
            }
        }
    }
}

struct UpComingMovieService:MovieServiceProtocol {
    private let apiManager:APIServiceProtocol
    init(apiManager:APIServiceProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
    func loadMovies(pageNo:Int) async throws -> MovieResponse {
        return try await withCheckedThrowingContinuation { continuation in
            self.apiManager.execute(responseType: MovieResponse.self, endpoint: .UpComing(pageNo: pageNo)) { result in
                continuation.resume(with: result)
            }
        }
    }
}


