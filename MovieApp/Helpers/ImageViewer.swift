//
//  ImageViewer.swift
//  MovieApp
//
//  Created by Aashish Tyagi on 10/8/22.
//

import UIKit

extension UIImageView {
    
     func showFullScreenImage(from vc:UIViewController){
        self.isUserInteractionEnabled = true
         guard let image = self.image else {
             return
         }
         
        let newImageView = UIImageView(image: image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        vc.view.addSubview(newImageView)
        vc.navigationController?.isNavigationBarHidden = true
        vc.tabBarController?.tabBar.isHidden = true
    }
    
    @objc private func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }
}


