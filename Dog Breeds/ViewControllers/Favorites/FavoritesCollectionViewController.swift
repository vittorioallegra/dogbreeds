//
//  FavoritesCollectionViewController.swift
//  Dog Breeds
//
//  Created by Vittorio Allegra on 29/01/22.
//

import UIKit

class FavoritesCollectionViewController: UICollectionViewController {
    private var list: [DogImage] = []
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorites"

        // Register cell classes
        self.collectionView!.register(
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

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.list.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DogImageCardViewCell.reuseIdentifier,
            for: indexPath
        ) as! DogImageCardViewCell
        
        let dog = self.list[indexPath.row]
        cell.dog = dog
        cell.isFavorite = true
        cell.showLabel = true
        cell.delegate = self
    
        return cell
    }
}

private extension FavoritesCollectionViewController {
    func loadFavorites() {
        self.list = Storage.getFavorites()
    }
}

extension FavoritesCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: self.view.bounds.width - 32, height: 400)
    }
}

extension FavoritesCollectionViewController: DogImageCardViewDelegate {
    func didToggleFavorite(_ dog: DogImage) {
        Storage.toggleFavorite(dog)
        self.loadFavorites()
        self.collectionView.reloadData()
    }
}
