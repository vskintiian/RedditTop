//
//  RedditTopPresenterImpl.swift
//  RedditTop
//
//  Created by Vladyslav Skintiyan on 12.04.2020.
//  Copyright © 2020 Vladyslav Skintiyan. All rights reserved.
//

import Foundation

final class RedditTopPresenterImpl: RedditTopViewOutput {

    weak private(set) var view: RedditTopViewInput!
    
    var interactor: RedditTopInteractor!
    var router: RedditTopRouter!
    
    required init(view: RedditTopViewInput) {
        self.view = view
    }
    
    func configureView() {}
}
