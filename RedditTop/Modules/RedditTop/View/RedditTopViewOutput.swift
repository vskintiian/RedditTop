//
//  RedditTopViewOutput.swift
//  RedditTop
//
//  Created by Vladyslav Skintiyan on 12.04.2020.
//  Copyright © 2020 Vladyslav Skintiyan. All rights reserved.
//

import Foundation

protocol RedditTopViewOutput {
    func viewIsReady()
    func refreshPosts()
    func didScrollToBottom()
    func didSelect(index: Int)
}
