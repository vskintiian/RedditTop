//
//  RedditListingPageDTO.swift
//  RedditTop
//
//  Created by Vladyslav Skintiyan on 12.04.2020.
//  Copyright © 2020 Vladyslav Skintiyan. All rights reserved.
//

import Foundation

// MARK: - RedditListingPageDTO
struct RedditListingPageDTO: Codable {
    let data: RedditListingPageDTOData
}

// MARK: - RedditListingPageDTOData
extension RedditListingPageDTO {
    struct RedditListingPageDTOData: Codable {
        let dist: Int
        let children: [RedditPostDTOData]
        let after: String
        let before: String?
    }
}
