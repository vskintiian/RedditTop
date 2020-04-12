//
//  ApplicationInitService.swift
//  RedditTop
//
//  Created by Vladyslav Skintiyan on 12.04.2020.
//  Copyright © 2020 Vladyslav Skintiyan. All rights reserved.
//

import UIKit

final class ApplicationInitService: NSObject, ApplicationService {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let configurator = RedditTopConfiguratorImpl()
        let topViewController = RedditTopViewController(configurator: configurator)
        let navigationController = UINavigationController(rootViewController: topViewController)

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        
        window!.windowScene = windowScene
        window!.rootViewController = navigationController
        
        window!.makeKeyAndVisible()
    }
}
