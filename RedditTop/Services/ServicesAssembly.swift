//
//  ServicesAssembly.swift
//  RedditTop
//
//  Created by Vladyslav Skintiyan on 12.04.2020.
//  Copyright © 2020 Vladyslav Skintiyan. All rights reserved.
//

import Foundation

protocol ServicesAssembly {
    var redditApiService: RedditAPIService { get }
    var imageFetchService: ImageFetchService { get }
    var postsLocalStorage: RedditPostsLocalStorage { get }
}

struct ServicesAssemblyInstance {
    static private var _services = ServicesAssemblyImpl()

    static var shared: ServicesAssembly {
        return _services
    }
}

private final class ServicesAssemblyImpl: ServicesAssembly {
    private lazy var requestExecutor: RequestsExecutor =
        { RequestsExecutorImpl() }()
    
    lazy var redditApiService: RedditAPIService =
        { return RedditAPIServiceImpl(executor: self.requestExecutor) }()
    
    lazy var imageFetchService: ImageFetchService =
        { return ImageFetchServiceImpl(executor: self.requestExecutor) }()
    
    lazy var postsLocalStorage: RedditPostsLocalStorage =
        { return RedditPostsLocalStorageImpl() }()
}
