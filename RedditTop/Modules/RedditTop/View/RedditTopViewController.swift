//
//  RedditTopViewController.swift
//  RedditTop
//
//  Created by Vladyslav Skintiyan on 12.04.2020.
//  Copyright © 2020 Vladyslav Skintiyan. All rights reserved.
//

import UIKit

final class RedditTopViewController: UIViewController, RedditTopViewInput {
    var output: RedditTopViewOutput!
    
    init(configurator: RedditTopConfigurator) {
        super.init(nibName: nil, bundle: nil)
        
        configurator.configure(with: self)
    }
    
    required init?(coder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
