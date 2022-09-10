//
//  ResponseParser.swift
//  CleanSwift
//
//  Created by Aashish Tyagi on 9/4/22.
//

import Foundation

protocol ResponseParserProtocol {
    func parse<T:Codable>(type:T.Type,data:Data,completion:(Result<T,Error>) -> Void)
}

struct ResponseParser:ResponseParserProtocol {
    private let jsonDecoder:JSONDecoder
    
    init(jsonDecoder:JSONDecoder =  JSONDecoder()) {
        self.jsonDecoder = jsonDecoder
    }
    
    func parse<T>(type: T.Type, data: Data, completion: (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        
        do {
            let model = try self.jsonDecoder.decode(T.self, from:data)
            completion(.success(model))
        }
        catch {
            completion(.failure(error))
        }
    }
}
