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
    
    private var viewDataModels: [RedditPostViewData] = [] {
        didSet {
            DispatchQueue.main.async {
                self.view.modelsUpdated(models: self.viewDataModels)
            }
        }
    }
    
    required init(view: RedditTopViewInput) {
        self.view = view
    }
    
    func viewIsReady() {
        interactor.fetchTopReddits { [weak self] posts in
            self?.viewDataModels = posts.map(RedditPostViewData.init)
        }
    }
}
