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
        let searchTableVC = SearchTableViewController()
        searchTableVC.delegate = self
        let searchNC = UINavigationController(rootViewController: searchTableVC)
        searchNC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: Tab.search.rawValue)
        searchNC.navigationBar.prefersLargeTitles = true
        
        let favoritesCollectionVC = FavoritesCollectionViewController()
        let favoritesNC = UINavigationController(rootViewController: favoritesCollectionVC)
        favoritesNC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: Tab.favorites.rawValue)
        favoritesNC.navigationBar.prefersLargeTitles = true
        
        self.rootViewController.viewControllers = [searchNC, favoritesNC]
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
