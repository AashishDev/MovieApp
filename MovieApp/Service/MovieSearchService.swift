//
//  MovieSearchService.swift
//  MovieApp
//
//  Created by Aashish Tyagi on 9/19/22.
//

import Foundation
import Networking


protocol MovieSearchServiceProtocol {
    func searchMovieByName(query:String) async throws -> MovieResponse
}

struct MovieSearchService:MovieSearchServiceProtocol {
    private let apiManager:APIServiceProtocol
    init(apiManager:APIServiceProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
    func searchMovieByName(query:String) async throws -> MovieResponse {
        
        return try await withCheckedThrowingContinuation { continuation in
            self.apiManager.execute(responseType: MovieResponse.self, endpoint: .Search(query: query)) { result in
                continuation.resume(with: result)
            }
        }
    }
}
