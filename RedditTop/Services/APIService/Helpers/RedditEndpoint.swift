//
//  RedditEndpoint.swift
//  RedditTop
//
//  Created by Vladyslav Skintiyan on 12.04.2020.
//  Copyright © 2020 Vladyslav Skintiyan. All rights reserved.
//

import Foundation

protocol URLProvidable {
    var url: URL { get }
}

struct RedditEndpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension RedditEndpoint: URLProvidable {
    private enum Constants {
        static let host = "reddit.com"
        static let scheme = "https"
    }
    
    var url: URL {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.host
        components.path = "/" + path
        components.queryItems = queryItems

        guard let url = components.url else { preconditionFailure("Invalid URL components: \(components)") }

        return url
    }
}

extension RedditEndpoint {
    static func top(after: String?, limit: Int = 10) -> Self {
        var queryItems = [
            URLQueryItem(name: "limit", value: String(limit)),
            URLQueryItem(name: "raw_json", value: String(1))
        ]
        
        if let after = after { queryItems.append(URLQueryItem(name: "after", value: String(after))) }
        
        return RedditEndpoint(path: "top.json", queryItems: queryItems)
    }
}
