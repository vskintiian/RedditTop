//
//  RedditTopRouterImpl.swift
//  RedditTop
//
//  Created by Vladyslav Skintiyan on 12.04.2020.
//  Copyright © 2020 Vladyslav Skintiyan. All rights reserved.
//

import UIKit
import SafariServices

final class RedditTopRouterImpl: RedditTopRouter {
    
    private weak var viewController: UIViewController!
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    // MARK: - RedditTopRouter
    
    func open(url: URL) {
        let safariVC = SFSafariViewController(url: url)
        viewController.present(safariVC, animated: true, completion: nil)
    }
}
