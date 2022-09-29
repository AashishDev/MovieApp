//
//  AppFlow.swift
//  MovieApp
//
//  Created by Aashish Tyagi on 9/29/22.
//

import UIKit

protocol Flow {
    func start()
}

class AppFlow:Flow {
   
    let navigation:UINavigationController?
    init(navigation:UINavigationController) {
        self.navigation =  navigation
    }
    
     func start() {
         
         let storyBoard = UIStoryboard(name: "Main", bundle: .main)
         if let tabBarController = storyBoard.instantiateViewController(
            withIdentifier: "TabBarController") as? TabBarController {
             self.navigation?.viewControllers = [tabBarController]
         }
    }
}
