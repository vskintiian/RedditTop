//
//  RedditTableCell.swift
//  RedditTop
//
//  Created by Vladyslav Skintiyan on 12.04.2020.
//  Copyright © 2020 Vladyslav Skintiyan. All rights reserved.
//

import UIKit

private enum Constants {
    static let titleFontSize: CGFloat = 16
    static let infoFontSize: CGFloat = 12
}

final class RedditTableCell: UITableViewCell {
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: Constants.titleFontSize)
        return titleLabel
    }()
    
    private let scoreLabel: UILabel = {
        let scoreLabel = UILabel()
        scoreLabel.font = UIFont.systemFont(ofSize: Constants.infoFontSize)
        return scoreLabel
    }()
    
    private let commentsCountLabel: UILabel = {
         let commentsCountLabel = UILabel()
        commentsCountLabel.font = UIFont.systemFont(ofSize: Constants.infoFontSize)
         return commentsCountLabel
    }()
    
    private let createdLabel: UILabel = {
        let createdLabel = UILabel()
        createdLabel.font = UIFont.systemFont(ofSize: Constants.infoFontSize)
        return createdLabel
    }()
    
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let loadingIndicator = UIActivityIndicatorView()
    
    private var task: Cancellable? {
        willSet { task?.cancel() }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        loadingIndicator.isHidden = true
        thumbnailImageView.image = nil
        task = nil
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
        [titleLabel, scoreLabel, commentsCountLabel, createdLabel, thumbnailImageView, loadingIndicator].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let thumbnailStreachingView = UIView()
        thumbnailStreachingView.translatesAutoresizingMaskIntoConstraints = false
        let thumbnailContainerStack = UIStackView(arrangedSubviews: [thumbnailImageView, thumbnailStreachingView])
        thumbnailContainerStack.axis = .vertical
        thumbnailContainerStack.alignment = .fill
        thumbnailContainerStack.distribution = .fill

        let postInfoStreachingView = UIView()
        postInfoStreachingView.translatesAutoresizingMaskIntoConstraints = false
        let postInfoContainerStack = UIStackView(arrangedSubviews: [titleLabel, scoreLabel, commentsCountLabel, createdLabel, postInfoStreachingView])
        postInfoContainerStack.axis = .vertical
        postInfoContainerStack.alignment = .fill
        postInfoContainerStack.distribution = .fill
        postInfoContainerStack.spacing = 5
        
        let mainContainerStack = UIStackView(arrangedSubviews: [thumbnailContainerStack, postInfoContainerStack])
        mainContainerStack.axis = .horizontal
        mainContainerStack.alignment = .fill
        mainContainerStack.distribution = .fill
        mainContainerStack.spacing = 15
        
        mainContainerStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mainContainerStack)
        
        NSLayoutConstraint.activate([
            mainContainerStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mainContainerStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            mainContainerStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainContainerStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        
        thumbnailImageView.widthAnchor.constraint(equalTo: thumbnailImageView.heightAnchor).isActive = true
        thumbnailImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: thumbnailImageView.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: thumbnailImageView.centerYAnchor)
        ])
        
        separatorInset = .zero
    }
    
    func update(with data: RedditPostViewData, imageFetchService: ImageFetchService = ServicesAssemblyInstance.shared.imageFetchService) {
        titleLabel.text = data.title
        scoreLabel.text = data.score
        commentsCountLabel.text = data.commentsCount
        createdLabel.text = data.created
        
        if let url = data.thumbnailImageUrl {
            loadingIndicator.startAnimating()
            task = imageFetchService.fetchImage(url: url) { [weak self] fromUrl, image in
                guard let self = self, fromUrl == url else { return }
                
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = image
                    self.loadingIndicator.stopAnimating()
                    self.loadingIndicator.isHidden = true
                }
            }
        }
    }
}
