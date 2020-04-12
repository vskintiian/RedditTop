//
//  ImageFetchServiceImpl.swift
//  RedditTop
//
//  Created by Vladyslav Skintiyan on 12.04.2020.
//  Copyright © 2020 Vladyslav Skintiyan. All rights reserved.
//

import UIKit

final class ImageFetchServiceImpl: ImageFetchService {
    let executor: RequestsExecutor
    
    init(executor: RequestsExecutor) {
        self.executor = executor
    }
    
    @discardableResult
    func fetchImage(url: URL, completion: @escaping (URL, UIImage?) -> Void) -> Cancellable? {
        let key = url.absoluteString as NSString
        
        if let cachedImage = ImageFetchServiceImpl.imageCache.object(forKey: key) {
            completion(url, cachedImage)
            return nil
        }
        
        let task = executor.executeData(url: url) { result in
            switch result {
            case let .success(response):
                if let image = UIImage(data: response.value) {
                    completion(url, image)
                    ImageFetchServiceImpl.imageCache.setObject(image, forKey: key)
                }
            case .failure:
                completion(url, nil)
            }
        }
        
        return task
    }
    
    private static let imageCache = NSCache<NSString, UIImage>()
}
