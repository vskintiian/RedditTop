//
//  RedditTopInteractorImpl.swift
//  RedditTop
//
//  Created by Vladyslav Skintiyan on 12.04.2020.
//  Copyright © 2020 Vladyslav Skintiyan. All rights reserved.
//

import Foundation

final class RedditTopInteractorImpl: RedditTopInteractor {

    private let redditApiService: RedditAPIService
    
    init(redditApiService: RedditAPIService) {
        self.redditApiService = redditApiService
    }
    
    private var currentFetchTask: Cancellable? {
        willSet { currentFetchTask?.cancel() }
    }
    
    private var lastPageId: String = ""
    private var posts: [RedditPostDTO] = []
    
    func fetchTopReddits(postsHandler handler: @escaping PostsHandler) {
        guard currentFetchTask == nil else { return }
        
        currentFetchTask = redditApiService.topReddits(after: lastPageId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(page):
                self.handleNewPage(page: page)
                handler(self.posts)
            case .failure:
                break
            }
            
            self.currentFetchTask = nil
        }
    }
 
    private func handleNewPage(page: RedditListingPageDTO) {
        lastPageId = page.lastPageId
        posts += page.posts
    }
}
