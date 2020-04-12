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
    
    func topReddits(after: String?, handler: @escaping RedditPageRequestHandler) -> Cancellable
}

extension RedditAPIService {
    func topReddits(handler: @escaping RedditPageRequestHandler) -> Cancellable {
        return topReddits(after: nil, handler: handler)
    }
}
