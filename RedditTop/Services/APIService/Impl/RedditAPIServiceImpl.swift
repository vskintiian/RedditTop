//
//  RedditAPIServiceImpl.swift
//  RedditTop
//
//  Created by Vladyslav Skintiyan on 12.04.2020.
//  Copyright © 2020 Vladyslav Skintiyan. All rights reserved.
//

import Foundation

final class RedditAPIServiceImpl: RedditAPIService {
    private let executor: RequestsExecutor
    
    init(executor: RequestsExecutor) {
        self.executor = executor
    }
    
    func topReddits(after: String?, handler: @escaping RedditPageRequestHandler) -> URLSessionDataTask {
        let endpoint = RedditEndpoint.top(after: after)
        
        let handler: (HandllerType<RedditListingPageDTO>) -> () = { result in
            switch result {
            case let .success(response):
                handler(.success(response.value))
            case let .failure(error):
                handler(.failure(error))
            }
        }
        
        return executor.execute(url: endpoint.url, handler: handler)
    }
}
