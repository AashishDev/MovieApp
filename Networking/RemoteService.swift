//
//  NetworkLayer.swift
//  CleanSwift
//
//  Created by Aashish Tyagi on 9/4/22.
//

import Foundation

public protocol RemoteServiceProtocol {
    func execute(request:URLRequest, completion: @escaping ((Result<Data, Error>) -> Void))
}

public struct RemoteService:RemoteServiceProtocol {
    private let session:URLSession
   public init(session:URLSession = URLSession.shared) {
        self.session = session
    }
    
    public func execute(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        
        self.session.dataTask(with: request) { data, _, error in
           
            guard let data = data else {
                completion(.failure(error!))
                return
            }
            completion(.success(data))
        }.resume()
    }
}
