//
//  FavoritesCollectionViewController.swift
//  Dog Breeds
//
//  Created by Vittorio Allegra on 29/01/22.
//

import UIKit

class FavoritesCollectionViewController: BaseCollectionViewController {
    private let searchController = DogBreedSearchController()
    private var selectedBreed: DogBreed?
    
    var list: [DogBreed] = [] { didSet { self.loadSearchOptions() } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorites"
        
        self.searchController.searchDelegate = self
        self.navigationItem.searchController = self.searchController

        self.collectionView.register(
            DogImageCardViewCell.self,
            forCellWithReuseIdentifier: DogImageCardViewCell.reuseIdentifier
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        return self.getFavorites().count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DogImageCardViewCell.reuseIdentifier,
            for: indexPath
        ) as! DogImageCardViewCell
        
        
        let dog = self.getFavorites()[indexPath.row]
        cell.dog = dog
        cell.isFavorite = true
        cell.showLabel = true
        cell.delegate = self
    
        return cell
    }
}

private extension FavoritesCollectionViewController {
    func loadSearchOptions() {
        self.searchController.searchOptions = self.list
    }
    
    func getFavorites() -> [DogImage] {
        let favorites = Storage.getFavorites()
        return self.selectedBreed == nil
            ? favorites
            : favorites.filter({ $0.breed == self.selectedBreed })
    }
}

extension FavoritesCollectionViewController: DogBreedSearchDelegate {
    func didSelectOption(_ option: DogBreed?) {
        self.selectedBreed = option
        self.collectionView.reloadData()
    }
}

extension FavoritesCollectionViewController: DogImageCardViewDelegate {
    func didToggleFavorite(_ dog: DogImage) {
        Storage.toggleFavorite(dog)
        self.collectionView.reloadData()
    }
}
