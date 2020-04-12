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
    
    // MARK: - Private
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(RedditTableCell.self, forCellReuseIdentifier: RedditTableCell.reuseIdentifier)
        tableView.register(LoadingTableCell.self, forCellReuseIdentifier: LoadingTableCell.reuseIdentifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView()
        
        return tableView
    }()
    
    private var models: [RedditViewCellItem] = [] {
        didSet { tableView.reloadData() }
    }
    
    init(configurator: RedditTopConfigurator) {
        super.init(nibName: nil, bundle: nil)
        
        configurator.configure(with: self)
    }
    
    required init?(coder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        output.viewIsReady()
    }
    
    private func configureLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: - RedditTopViewInput
    
    func setTitle(title: String) {
        self.title = title
    }
    
    func modelsUpdated(models: [RedditViewCellItem]) {
        self.models = models
    }
}

extension RedditTopViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = models[safe: indexPath.row] else {
            return UITableViewCell()
        }
        
        let resultCell: UITableViewCell
        
        if case let .post(postData) = model,
            let cell = tableView.dequeueReusableCell(withIdentifier: RedditTableCell.reuseIdentifier, for: indexPath) as? RedditTableCell {
            cell.update(with: postData)
            resultCell = cell
        } else if case .loadNextPage = model,
            let cell = tableView.dequeueReusableCell(withIdentifier: LoadingTableCell.reuseIdentifier, for: indexPath) as? LoadingTableCell {
            cell.startAnimating()
            resultCell = cell
        } else {
            resultCell = UITableViewCell()
        }
        
        return resultCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell is LoadingTableCell {
            output.didScrollToBottom()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        output.didSelect(index: indexPath.row)
    }
}
