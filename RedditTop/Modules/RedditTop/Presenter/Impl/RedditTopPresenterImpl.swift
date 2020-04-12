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
    
    private var cellItems: [RedditViewCellItem] = [] {
        didSet {
            DispatchQueue.main.async {
                self.view.modelsUpdated(models: self.cellItems)
            }
        }
    }
    
    required init(view: RedditTopViewInput) {
        self.view = view
    }
    
    // MARK: - RedditTopViewOutput
    
    func viewIsReady() {
        view.setTitle(title: "🔝 Reddit")
        cellItems = [.loadNextPage]
        fetchAndUpdateData()
    }
    
    func didScrollToBottom() {
        fetchAndUpdateData()
    }
    
    func didSelect(index: Int) {
        guard let url = interactor.previewImageUrl(at: index) else { return }
        router.open(url: url)
    }
    
    // MARK: - Private
    
    private func fetchAndUpdateData() {
        interactor.fetchTopReddits() { [weak self] posts in
            self?.cellItems = posts.map(RedditPostViewData.init).map { RedditViewCellItem.post(data: $0) } + [.loadNextPage]
        }
    }
}
