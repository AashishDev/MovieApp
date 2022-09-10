//
//  APIManager.swift
//  CleanSwift
//
//  Created by Aashish Tyagi on 9/4/22.
//

import Foundation

enum APIError:Error {
case InValidURL
}

protocol APIServiceProtocol {
    func execute<T:Codable>(responseType: T.Type, endpoint: EndPoint, completion: @escaping ((Result<T, Error>) -> Void))
}

class APIManager:APIServiceProtocol {
    private let remoteService:RemoteServiceProtocol
    private let parser:ResponseParserProtocol
    
    init(remoteService: RemoteServiceProtocol = RemoteService(), parser: ResponseParserProtocol = ResponseParser()) {
        self.remoteService = remoteService
        self.parser = parser
    }
    
    func execute<T>(responseType: T.Type, endpoint: EndPoint, completion: @escaping ((Result<T, Error>) -> Void)) where T : Decodable, T : Encodable {
        
        guard let url = URL(string: endpoint.path) else {
            completion(.failure(APIError.InValidURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.requestType
        
        self.remoteService.execute(request: urlRequest) { result in
            
            switch result {
            case .success(let data):
                //Parsing here
                self.parser.parse(type: T.self, data: data) { parseResult in
                    
                    switch parseResult {
                    case .success(let model):
                        completion(.success(model))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
