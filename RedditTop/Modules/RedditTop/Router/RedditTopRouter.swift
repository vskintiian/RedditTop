//
//  RedditTopRouter.swift
//  RedditTop
//
//  Created by Vladyslav Skintiyan on 12.04.2020.
//  Copyright © 2020 Vladyslav Skintiyan. All rights reserved.
//

import Foundation

protocol RedditTopRouter {
    func open(url: URL)
    func handleError(error: Error, retry handler: (() -> Void)?)
}

extension RedditTopRouter {
    func handleError(error: Error) {
        handleError(error: error, retry: nil)
    }
}
