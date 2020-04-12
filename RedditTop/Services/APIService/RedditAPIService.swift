//
//  RedditAPIService.swift
//  RedditTop
//
//  Created by Vladyslav Skintiyan on 12.04.2020.
//  Copyright © 2020 Vladyslav Skintiyan. All rights reserved.
//

import Foundation

protocol RedditAPIService {
    typealias RedditPageRequestHandler = (Result<RedditListingPageDTO, Error>) -> ()
    
    func topReddits(after: String?, handler: @escaping RedditPageRequestHandler) -> URLSessionDataTask
}

extension RedditAPIService {
    func topReddits(handler: @escaping RedditPageRequestHandler) -> URLSessionDataTask {
        return topReddits(after: nil, handler: handler)
    }
}
