//
//  MainRouter.swift
//  Dog Breeds
//
//  Created by Vittorio Allegra on 29/01/22.
//

import Foundation
import UIKit

class MainRouter: NSObject {
    private let rootViewController: UITabBarController
    private enum Tab: Int {
        case search
        case favorites
    }
    
    override init() {
        self.rootViewController = Self.getRootViewController()
        super.init()
    }
    
    func getRootViewController() -> UIViewController {
        return self.rootViewController
    }
}

private extension MainRouter {
    static func getRootViewController() -> UITabBarController {
        let dogBreedsViewController = DogBreedsViewController()
        let listNavigationController = UINavigationController(rootViewController: dogBreedsViewController)
        listNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: Tab.search.rawValue)
        
        let favoritesViewController = FavoritesViewController()
        let favoritesNavigationController = UINavigationController(rootViewController: favoritesViewController)
        favoritesNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: Tab.favorites.rawValue)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [listNavigationController, favoritesNavigationController]
        
        return tabBarController
    }
}
