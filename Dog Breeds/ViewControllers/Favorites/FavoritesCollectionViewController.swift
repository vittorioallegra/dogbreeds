//
//  FavoritesCollectionViewController.swift
//  Dog Breeds
//
//  Created by Vittorio Allegra on 29/01/22.
//

import UIKit

class FavoritesCollectionViewController: UICollectionViewController {
    private let searchController = UISearchController(searchResultsController: nil)
    private var favorites: [DogImage] = []
    private var filteredFavorites: [DogImage] = []
    
    var list: [DogBreed] = []
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorites"
        
        self.searchController.searchResultsUpdater = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.sizeToFit()
        self.navigationItem.searchController = self.searchController

        // Register cell classes
        self.collectionView.register(
            DogImageCardViewCell.self,
            forCellWithReuseIdentifier: DogImageCardViewCell.reuseIdentifier
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadFavorites()
        self.collectionView.reloadData()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(
        in collectionView: UICollectionView
    ) -> Int {
        return 1
    }


    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return self.searchController.isActive
            ? self.filteredFavorites.count
            : self.favorites.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DogImageCardViewCell.reuseIdentifier,
            for: indexPath
        ) as! DogImageCardViewCell
        
        
        let dog = self.searchController.isActive
            ? self.filteredFavorites[indexPath.row]
            : self.favorites[indexPath.row]
        cell.dog = dog
        cell.isFavorite = true
        cell.showLabel = true
        cell.delegate = self
    
        return cell
    }
}

private extension FavoritesCollectionViewController {
    func loadFavorites() {
        self.favorites = Storage.getFavorites()
    }
}

extension FavoritesCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(
            width: self.view.bounds.width - Settings.padding * 2,
            height: Settings.cardHeight
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return Settings.padding
    }
}

extension FavoritesCollectionViewController: UISearchResultsUpdating {
    func updateSearchResults(
        for searchController: UISearchController
    ) {
        guard self.favorites.count != 0,
              let text = searchController.searchBar.text else {
            return
        }
        
        self.filteredFavorites = text.isEmpty
            ? self.favorites
            : self.favorites.filter({ $0.breed.lowercased().contains(text.lowercased()) })
        self.collectionView.reloadData()
    }
}

extension FavoritesCollectionViewController: DogImageCardViewDelegate {
    func didToggleFavorite(_ dog: DogImage) {
        Storage.toggleFavorite(dog)
        self.loadFavorites()
        self.collectionView.reloadData()
    }
}
