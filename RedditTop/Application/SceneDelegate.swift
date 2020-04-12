//
//  SceneDelegate.swift
//  RedditTop
//
//  Created by Vladyslav Skintiyan on 12.04.2020.
//  Copyright © 2020 Vladyslav Skintiyan. All rights reserved.
//

import UIKit

class SceneDelegate: BaseSceneDelegate {
    override var services: [ApplicationService] {
        return [
            ApplicationInitService()
        ]
    }
}
