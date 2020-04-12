//
//  RedditTopInteractor.swift
//  RedditTop
//
//  Created by Vladyslav Skintiyan on 12.04.2020.
//  Copyright © 2020 Vladyslav Skintiyan. All rights reserved.
//

import Foundation

protocol RedditTopInteractor {
    typealias PostsHandler = (Result<[RedditPostDTO], Error>) -> Void
    typealias PostsLocalHandler = ([RedditPostDTO]) -> Void
    
    func fetchFromLocalStorage(postsHandler handler: @escaping PostsLocalHandler)
    func fetchTopReddits(postsHandler handler: @escaping PostsHandler)
    func reloadTopReddits(postsHandler handler: @escaping PostsHandler)
    func previewImageUrl(at index: Int) -> URL?
}
