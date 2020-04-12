//
//  RedditTopViewController.swift
//  RedditTop
//
//  Created by Vladyslav Skintiyan on 12.04.2020.
//  Copyright © 2020 Vladyslav Skintiyan. All rights reserved.
//

import UIKit

final class RedditTopViewController: UIViewController, RedditTopViewInput {
    private let configurator: RedditTopConfigurator = RedditTopConfiguratorImpl()
    
    var output: RedditTopViewOutput!
}
