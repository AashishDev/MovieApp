//
//  StoryBoardUtils.swift
//  MovieApp
//
//  Created by Aashish Tyagi on 10/8/22.
//

import UIKit

enum StoryBoard:String {
    case Main
    case Movie
    case Search
    case Detail
}


protocol Storyboardable {
    static var storyboardName: StoryBoard { get }
    static var storyboardBundle: Bundle { get }
    static var storyboardIdentifier: String { get }
    
    static func instantiate() -> Self
}

extension Storyboardable where Self: UIViewController {
    static var storyBoardName:StoryBoard {
        return .Main
    }
    
    static var storyboardBundle: Bundle {
        return .main
    }
    
    static var storyboardIdentifier:String {
        return String(describing: self)
    }
    
    static func instantiate() -> Self {
        
        guard let viewController = UIStoryboard(name: storyBoardName.rawValue,
                                                bundle: storyboardBundle)
                                .instantiateViewController(
                                                withIdentifier: storyboardIdentifier) as? Self else {
           
            fatalError("Unable to Instantiate View Controller With Storyboard Identifier \(storyboardIdentifier)")
        }
        return viewController
    }
}
