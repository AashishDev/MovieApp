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
    func loadMovies(path:String,completion:@escaping (Result<MovieResponse,Error>) -> Void)
}

struct MovieService:MovieServiceProtocol {
    private let apiManager:APIServiceProtocol
    init(apiManager:APIServiceProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
    func loadMovies(path:String,completion:@escaping (Result<MovieResponse,Error>) -> Void) {
        
        let url = URL(string: path)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        self.apiManager.execute(responseType: MovieResponse.self, urlRequest: urlRequest) { result in
            completion(result)
        }
    }
}
