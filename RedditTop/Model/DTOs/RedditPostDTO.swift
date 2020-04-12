//
//  RedditPostDTO.swift
//  RedditTop
//
//  Created by Vladyslav Skintiyan on 12.04.2020.
//  Copyright © 2020 Vladyslav Skintiyan. All rights reserved.
//

import Foundation

// MARK: - RedditPostDTOData
typealias RedditPostDTOData = RedditPostDTO.RedditPostDTOData
extension RedditPostDTO {
    struct RedditPostDTOData: Codable {
        let data: RedditPostDTO
    }
}

// MARK: - RedditPostDTO
struct RedditPostDTO: Codable {
    let author: String
    let title: String
    let created: TimeInterval
    let thumbnail: URL?
    let preview: Preview?
    let numComments: Int
    let score: Int

    enum CodingKeys: String, CodingKey {
        case author, title, created, thumbnail, preview, score
        
        case numComments = "num_comments"
    }
}

// MARK: - Preview
extension RedditPostDTO {
    struct Preview: Codable {
        let images: [Image]
        let enabled: Bool
        
        enum CodingKeys: String, CodingKey {
            case images, enabled
        }
        
        var sourceURL: URL? {
            let urlString = images.first?.source.url
            return urlString.flatMap(URL.init(string:))
        }
    }
}

// MARK: - Image
extension RedditPostDTO.Preview {
    struct Image: Codable {
        let source: Source
    }
    
    // MARK: - Source
    struct Source: Codable {
        let url: String
    }
}
