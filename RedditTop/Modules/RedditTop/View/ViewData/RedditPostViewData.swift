//
//  RedditPostViewData.swift
//  RedditTop
//
//  Created by Vladyslav Skintiyan on 12.04.2020.
//  Copyright © 2020 Vladyslav Skintiyan. All rights reserved.
//

import Foundation

struct RedditPostViewData {
    let title: String
    let score: String
    let commentsCount: String
    let created: String
    let thumbnailImageUrl: URL?
    
    init(dto: RedditPostDTO) {
        self.title = dto.title
        self.created = "Posted by \(dto.author) \(Date.agoHoursString(from: Date(timeIntervalSince1970: dto.created)))"
        self.commentsCount = "💬 \(dto.numComments) comments"
        self.score = "↕️ \(dto.score)"
        self.thumbnailImageUrl = dto.thumbnail ?? dto.previewURL
    }
}

extension RedditPostDTO {
    var previewURL: URL? {
        return preview?.sourceURL
    }
}
