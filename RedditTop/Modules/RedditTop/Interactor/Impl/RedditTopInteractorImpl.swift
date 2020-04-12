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
    private let localStorage: RedditPostsLocalStorage
    
    init(redditApiService: RedditAPIService, localStorage: RedditPostsLocalStorage) {
        self.redditApiService = redditApiService
        self.localStorage = localStorage
    }
    
    private var currentFetchTask: Cancellable? {
        willSet { currentFetchTask?.cancel() }
    }
    
    private var lastPageId: String = ""
    private var posts: [RedditPostDTO] = []
    
    // MARK: - RedditTopInteractor
    
    func fetchFromLocalStorage(postsHandler handler: @escaping PostsLocalHandler) {
        loadDataFromStorage()
        handler(posts)
    }
    
    func fetchTopReddits(postsHandler handler: @escaping PostsHandler) {
        guard currentFetchTask == nil else { return }
        
        if posts.isEmpty == false, lastPageId.isEmpty == true {
            // TODO: this means that we've reached the bottom. Handle it
        }
        
        currentFetchTask = redditApiService.topReddits(after: lastPageId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(page):
                self.handleNewPage(page: page)
                handler(.success(self.posts))
            case let .failure(error):
                handler(.failure(error))
            }
            
            self.currentFetchTask = nil
        }
    }
    
    func reloadTopReddits(postsHandler handler: @escaping PostsHandler) {
        posts = []
        lastPageId = ""
        fetchTopReddits(postsHandler: handler)
    }
    
    func previewImageUrl(at index: Int) -> URL? {
        return posts[safe: index]?.previewURL
    }
    
    // MARK: - Private
    
    private func handleNewPage(page: RedditListingPageDTO) {
        lastPageId = page.lastPageId
        posts += page.posts
        
        localStorage.posts = posts
        localStorage.lastPageId = lastPageId
    }
    
    private func loadDataFromStorage() {
        lastPageId = localStorage.lastPageId ?? ""
        posts = localStorage.posts
    }
}
