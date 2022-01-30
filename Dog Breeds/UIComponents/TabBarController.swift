//
//  TabBarController.swift
//  Dog Breeds
//
//  Created by Vittorio Allegra on 30/01/22.
//

import UIKit

enum Tab: Int {
    case search
    case favorites
}

class TabBarController: UITabBarController {
    private let loadingVC = LoadingViewController()
    private var isLoading: Bool = false { didSet { self.toggleLoadingVC() } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initTabBarController()
    }
}

private extension TabBarController {
    func initTabBarController() {
        let searchTableVC = SearchTableViewController()
        searchTableVC.delegate = self
        let searchNC = UINavigationController(rootViewController: searchTableVC)
        searchNC.tabBarItem = UITabBarItem(
            tabBarSystemItem: .search,
            tag: Tab.search.rawValue
        )
        searchNC.navigationBar.prefersLargeTitles = true
        
        let favoritesCollectionVC = FavoritesCollectionViewController()
        let favoritesNC = UINavigationController(rootViewController: favoritesCollectionVC)
        favoritesNC.tabBarItem = UITabBarItem(
            tabBarSystemItem: .favorites,
            tag: Tab.favorites.rawValue
        )
        favoritesNC.navigationBar.prefersLargeTitles = true
        
        self.viewControllers = [searchNC, favoritesNC]
        
        self.isLoading = true
        DogServiceApi.getDogBreeds { result, error in
            self.isLoading = false
            
            guard let result = result else {
                self.showErrorMessage(error)
                return
            }

            searchTableVC.list = result
            favoritesCollectionVC.list = result
        }
    }
    
    func toggleLoadingVC() {
        DispatchQueue.main.async {
            if self.isLoading {
                self.loadingVC.view.frame = AppDelegate.shared.window!.frame
                self.loadingVC.view.layoutIfNeeded()
                self.loadingVC.modalPresentationStyle = .overFullScreen
                self.present(self.loadingVC, animated: false)
            } else {
                self.loadingVC.dismiss(animated: false)
            }
        }
    }
    
    func showErrorMessage(_ error: Error?) {
        DispatchQueue.main.async {
            let message = error?.localizedDescription ?? ""
            
            let alert = UIAlertController(
                title: "Error",
                message: message,
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(
                title: "Close",
                style: .default,
                handler: { _ in
                    alert.dismiss(animated: true)
                }
            ))
            self.present(alert, animated: true)
        }
    }
    
    func push(_ viewController: UIViewController, in tab: Tab) {
        DispatchQueue.main.async {
            guard let viewControllers = self.viewControllers,
                  let navigationController = viewControllers[tab.rawValue] as? UINavigationController else {
                return
            }
            
            navigationController.pushViewController(viewController, animated: true)
        }
    }
}

extension TabBarController: SearchTableViewDelegate {
    func didSelectDogBreed(_ breed: String) {
        let dogBreedCollectionVC = DogBreedCollectionViewController(dogBreed: breed)
        dogBreedCollectionVC.delegate = self
        self.push(dogBreedCollectionVC, in: .search)
    }
}

extension TabBarController: DogBreedCollectionViewDelegate {
    func setLoading(_ isLoading: Bool) {
        self.isLoading = isLoading
    }
    
    func didReceiveError(_ error: Error?) {
        self.showErrorMessage(error)
    }
}
