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

let BasePath = "https://api.themoviedb.org/3/movie/"
let APIKey = "11c5d3b2a72c53e38a4b740b08d28921"
let language = "language=en-US"

enum EndPoint {
    case NowPlaying(pageNo:Int)
    case Popular(pageNo:Int)
    case UpComing(pageNo:Int)
    
    var requestType:String {
        switch self {
        case .NowPlaying, .Popular, .UpComing :
            return HTTPMethods.GET.rawValue
        }
    }
    
    // let movieList = "https://api.themoviedb.org/3/movie/now_playing?api_key=c&language=en-US&page=1"
    
    var path:String {
        
        switch self {
        case .NowPlaying(let pageNo):
            return BasePath + "now_playing?api_key=\(APIKey)&\(language)&page=\(pageNo)"
        case .Popular(let pageNo):
            return BasePath + "popular?api_key=\(APIKey)&\(language)&page=\(pageNo)"
        case .UpComing(let pageNo):
            return BasePath + "upcoming?api_key=\(APIKey)&\(language)&page=\(pageNo)"
        }
    }
}
