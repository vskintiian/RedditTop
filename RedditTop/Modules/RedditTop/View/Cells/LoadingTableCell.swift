//
//  LoadingTableCell.swift
//  RedditTop
//
//  Created by Vladyslav Skintiyan on 12.04.2020.
//  Copyright © 2020 Vladyslav Skintiyan. All rights reserved.
//

import UIKit

final class LoadingTableCell: UITableViewCell {
    private let indicatorView = UIActivityIndicatorView()

    func startAnimating() {
        indicatorView.startAnimating()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureLayout()
    }
    
    func configureLayout() {
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(indicatorView)
        
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            indicatorView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 20),
            indicatorView.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: -20)
        ])
        
        separatorInset = .zero
    }
}
