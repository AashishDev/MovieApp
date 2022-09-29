//
//  SceneDelegate.swift
//  MovieApp
//
//  Created by Aashish Tyagi on 9/8/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    lazy var navigationController:UINavigationController = {
        return UINavigationController()
    }()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
  
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let flow = AppFlow(navigation: navigationController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        flow.start()
    }
}

