//
//  RedditPostsLocalStorage.swift
//  RedditTop
//
//  Created by Vladyslav Skintiyan on 12.04.2020.
//  Copyright © 2020 Vladyslav Skintiyan. All rights reserved.
//

import Foundation

protocol RedditPostsLocalStorage: class {
    var posts: [RedditPostDTO] { get set }
    var lastPageId: String? { get set }
}
