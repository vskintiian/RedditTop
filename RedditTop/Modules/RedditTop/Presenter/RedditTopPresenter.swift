//
//  RedditTopPresenter.swift
//  RedditTop
//
//  Created by Vladyslav Skintiyan on 12.04.2020.
//  Copyright © 2020 Vladyslav Skintiyan. All rights reserved.
//

import Foundation

protocol RedditTopPresenter {
    var router: RedditTopRouter! { get set }
    var interactor: RedditTopInteractor! { get set }
    
    func configureView()
}
