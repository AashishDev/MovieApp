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
        let tabBarController = TabBarController.instantiate()
        self.navigation?.viewControllers = [tabBarController]
    }
}
