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

public enum EndPoint {
    case NowPlaying(pageNo:Int)
    case Popular(pageNo:Int)
    case UpComing(pageNo:Int)
    
    var rawValue:Int {
        switch self {
        case .NowPlaying(_):
            return 0
        case .Popular(_):
            return 1
        case .UpComing(_):
            return 2
        }
    }
    
    var requestType:String {
        switch self {
        case .NowPlaying, .Popular, .UpComing :
            return HTTPMethods.GET.rawValue
        }
    }
    
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
