//
//  FavoritesCollectionViewController.swift
//  Dog Breeds
//
//  Created by Vittorio Allegra on 29/01/22.
//

import UIKit

class FavoritesCollectionViewController: UICollectionViewController {
    private let searchController = DogBreedSearchController()
    private var favorites: [DogImage] = []
    private var selectedBreed: DogBreed?
    private var filteredFavorites: [DogImage] = []
    
    var list: [DogBreed] = [] { didSet { self.loadSearchOptions() } }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorites"
        
        self.searchController.searchDelegate = self
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
        return self.selectedBreed == nil
            ? self.favorites.count
            : self.filteredFavorites.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DogImageCardViewCell.reuseIdentifier,
            for: indexPath
        ) as! DogImageCardViewCell
        
        
        let dog = self.selectedBreed == nil
            ? self.favorites[indexPath.row]
            : self.filteredFavorites[indexPath.row]
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

extension FavoritesCollectionViewController: DogBreedSearchDelegate {
    func didSelectOption(_ option: DogBreed?) {
        self.selectedBreed = option
        self.filteredFavorites = option == nil
            ? self.favorites
            : self.favorites.filter({ $0.breed.lowercased().contains(option!.lowercased()) })
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
