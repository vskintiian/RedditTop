//
//  RedditPostsLocalStorageImpl.swift
//  RedditTop
//
//  Created by Vladyslav Skintiyan on 12.04.2020.
//  Copyright © 2020 Vladyslav Skintiyan. All rights reserved.
//

import Foundation

final class RedditPostsLocalStorageImpl: RedditPostsLocalStorage {
    private enum Constants {
        static let postsKey = "reddit.posts"
        static let lasstPageIdKey = "reddit.lastPageId"
    }
    
    let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    var posts: [RedditPostDTO] {
        get {
            guard let postsData = userDefaults.object(forKey: Constants.postsKey) as? Data,
                let posts = try? JSONDecoder().decode([RedditPostDTO].self, from: postsData) else {
                return []
            }
            
            return posts
        }
        
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                userDefaults.set(encoded, forKey: Constants.postsKey)
                userDefaults.synchronize()
            }
        }
    }
    
    var lastPageId: String? {
        get { userDefaults.string(forKey: Constants.lasstPageIdKey) }
        set {
            userDefaults.set(newValue, forKey: Constants.lasstPageIdKey)
            userDefaults.synchronize()
        }
    }
}
