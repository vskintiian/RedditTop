//
//  RedditTopConfiguratorImpl.swift
//  RedditTop
//
//  Created by Vladyslav Skintiyan on 12.04.2020.
//  Copyright © 2020 Vladyslav Skintiyan. All rights reserved.
//

import Foundation

final class RedditTopConfiguratorImpl: RedditTopConfigurator {
    
    func configure(with viewController: RedditTopViewController) {
        let interactor = RedditTopInteractorImpl()
        let presenter = RedditTopPresenterImpl(view: viewController)
        let router = RedditTopRouterImpl(viewController: viewController)
        
        viewController.output = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
