//
//  MainRouter.swift
//  Dog Breeds
//
//  Created by Vittorio Allegra on 29/01/22.
//

import Foundation
import UIKit

class MainRouter: NSObject {
    private let rootViewController = UITabBarController()
    private enum Tab: Int {
        case search
        case favorites
    }
    
    func getRootViewController() -> UIViewController {
        self.initRootViewController()
        return self.rootViewController
    }
}

private extension MainRouter {
    func initRootViewController() {
        let searchTableViewController = SearchTableViewController()
        searchTableViewController.delegate = self
        let searchNavigationController = UINavigationController(rootViewController: searchTableViewController)
        searchNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: Tab.search.rawValue)
        searchNavigationController.navigationBar.prefersLargeTitles = true
        
        let favoritesViewController = FavoritesViewController()
        let favoritesNavigationController = UINavigationController(rootViewController: favoritesViewController)
        favoritesNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: Tab.favorites.rawValue)
        favoritesNavigationController.navigationBar.prefersLargeTitles = true
        
        self.rootViewController.viewControllers = [searchNavigationController, favoritesNavigationController]
    }
    
    private func push(_ viewController: UIViewController, in tab: Tab) {
        DispatchQueue.main.async {
            let navigationController = self.rootViewController.viewControllers![tab.rawValue] as! UINavigationController
            navigationController.pushViewController(viewController, animated: true)
        }
    }
}

extension MainRouter: SearchTableViewDelegate {
    func didSelectDogBreed(_ breed: String) {
        let dogBreedCollectionVC = DogBreedCollectionViewController(dogBreed: breed)
        self.push(dogBreedCollectionVC, in: .search)
    }
}
