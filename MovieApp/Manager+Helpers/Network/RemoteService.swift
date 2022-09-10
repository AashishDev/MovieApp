//
//  NetworkLayer.swift
//  CleanSwift
//
//  Created by Aashish Tyagi on 9/4/22.
//

import Foundation

protocol RemoteServiceProtocol {
    func execute(request:URLRequest,completion: @escaping ((Result<Data,Error>) -> Void))
}

struct RemoteService:RemoteServiceProtocol {
    private let session:URLSession
    init(session:URLSession = URLSession.shared) {
        self.session = session
    }
    
    func execute(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        
        self.session.dataTask(with: request) { data, _, error in
           
            guard let data = data else {
                completion(.failure(error!))
                return
            }
            completion(.success(data))
        }.resume()
    }
}
