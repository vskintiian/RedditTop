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
        DispatchQueue.main.async {
            let safariVC = SFSafariViewController(url: url)
            self.viewController.present(safariVC, animated: true, completion: nil)
        }
    }
    
    func handleError(error: Error, retry handler: (() -> Void)?) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Ooops!", message: "Something went wrong...", preferredStyle: .alert)
            
            let actionTitle = handler == nil ? "Ok" : "Retry"
            let buttonAction = UIAlertAction(title: actionTitle, style: .default) { _ in
                handler?()
            }
            
            alertController.addAction(buttonAction)
            self.viewController.present(alertController, animated: true, completion: nil)
        }
    }
}
