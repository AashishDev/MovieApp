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

let BasePath = "https://api.themoviedb.org/3/"
let APIKey = "11c5d3b2a72c53e38a4b740b08d28921"
let language = "language=en-US"

public enum EndPoint {
    case NowPlaying(pageNo:Int)
    case Popular(pageNo:Int)
    case UpComing(pageNo:Int)
    case MovieDetail(id:Int)
    case Search(query:String)
    
    var rawValue:Int {
        switch self {
        case .NowPlaying(_):
            return 0
        case .Popular(_):
            return 1
        case .UpComing(_):
            return 2
        case .MovieDetail(_):
            return 3
        case .Search(_):
            return 4
        }
    }
    
    var requestType:String {
        switch self {
        case .NowPlaying, .Popular, .UpComing,.MovieDetail,.Search :
            return HTTPMethods.GET.rawValue
        }
    }
    
    var path:String {
        switch self {
        case .NowPlaying(let pageNo):
            return BasePath + "movie/now_playing?api_key=\(APIKey)&\(language)&page=\(pageNo)&include_adult=false"
        case .Popular(let pageNo):
            return BasePath + "movie/popular?api_key=\(APIKey)&\(language)&page=\(pageNo)&include_adult=false"
        case .UpComing(let pageNo):
            return BasePath + "movie/upcoming?api_key=\(APIKey)&\(language)&page=\(pageNo)&include_adult=false"
        case .MovieDetail(id: let id):
            return BasePath + "movie/\(id)?api_key=\(APIKey)&\(language)&include_adult=false"
        case .Search(let query):
            return BasePath + "search/movie?api_key=\(APIKey)&\(language)&page=1&query=\(query)&include_adult=false"
        }
    }
}

