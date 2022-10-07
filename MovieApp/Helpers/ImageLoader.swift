//
//  ImageCache.swift
//  MovieApp
//
//  Created by Aashish Tyagi on 10/7/22.
//

import UIKit
import Combine

fileprivate let cache = NSCache<AnyObject, AnyObject>()
final class ImageLoader {
    
    func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
        
        if let imageFromCache = cache.object(forKey: url as AnyObject) as? UIImage{
            return Just(imageFromCache).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { (data, response) -> UIImage? in return UIImage(data: data) }
            .catch { error in return Just(nil) }
            .handleEvents(receiveOutput: { /*[unowned self]*/ image in
                guard let image = image else { return }
                cache.setObject(image, forKey: url as AnyObject)
            })
            .subscribe(on: DispatchQueue.global() )
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

extension UIImageView {
    func loadImage(with url:URL) {
        _ = ImageLoader().loadImage(from:url).sink { image in
            self.image = image
        }
    }
}
