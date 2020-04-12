//
//  ImageFetchService.swift
//  RedditTop
//
//  Created by Vladyslav Skintiyan on 12.04.2020.
//  Copyright © 2020 Vladyslav Skintiyan. All rights reserved.
//

import UIKit

protocol ImageFetchService {
    @discardableResult
    func fetchImage(url: URL, completion: @escaping (URL, UIImage?) -> Void) -> Cancellable?
}
