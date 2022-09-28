//
//  Endpoint.swift
//  MovieApp
//
//  Created by Aashish Tyagi on 9/10/22.
//

import Foundation

enum HTTPMethods:String {
    case GET
    case POST
}

let basePath = "https://api.themoviedb.org/3/"
let APIKey = "11c5d3b2a72c53e38a4b740b08d28921"
let language = "language=en-US"

public enum EndPoint {
    case nowPlaying(_ pageNo:Int)
    case popular(_ pageNo:Int)
    case upComing(_ pageNo:Int)
    case movieDetail(_ id:Int)
    case search(_ query:String)
    
    var rawValue:Int {
        switch self {
        case .nowPlaying:
            return 0
        case .popular:
            return 1
        case .upComing:
            return 2
        case .movieDetail:
            return 3
        case .search:
            return 4
        }
    }
    
    var requestType:String {
        switch self {
        case .nowPlaying, .popular, .upComing, .movieDetail, .search :
            return HTTPMethods.GET.rawValue
        }
    }
    
    var path:String {
        switch self {
        case .nowPlaying(let pageNo):
            return basePath + "movie/now_playing?api_key=\(APIKey)&\(language)&page=\(pageNo)&include_adult=false"
        case .popular(let pageNo):
            return basePath + "movie/popular?api_key=\(APIKey)&\(language)&page=\(pageNo)&include_adult=false"
        case .upComing(let pageNo):
            return basePath + "movie/upcoming?api_key=\(APIKey)&\(language)&page=\(pageNo)&include_adult=false"
        case .movieDetail(id: let id):
            return basePath + "movie/\(id)?api_key=\(APIKey)&\(language)&include_adult=false"
        case .search(let query):
            return basePath + "search/movie?api_key=\(APIKey)&\(language)&page=1&query=\(query)&include_adult=false"
        }
    }
}

