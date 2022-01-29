//
//  DogBreedCollectionViewController.swift
//  Dog Breeds
//
//  Created by Vittorio Allegra on 29/01/22.
//

import UIKit

class DogBreedCollectionViewController: UICollectionViewController {
    private var list: [String] = []
    private var favorites: [String] = []
    
    private let dogBreed: String
    
    init(dogBreed: String) {
        self.dogBreed = dogBreed
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.dogBreed

        // Register cell classes
        self.collectionView!.register(
            DogImageCardViewCell.self,
            forCellWithReuseIdentifier: DogImageCardViewCell.reuseIdentifier
        )

        self.loadFavorites()
        self.loadDogBreedImagesList()
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
        
        let image = self.list[indexPath.row]
        cell.image = image
        cell.isFavorite = self.favorites.contains(image)
        cell.delegate = self
    
        return cell
    }
}

private extension DogBreedCollectionViewController {
    func loadFavorites() {
        self.favorites = Storage.getFavorites()
    }
    
    func loadDogBreedImagesList() {
        DogServiceApi.getDogBreedImages(dogBreed: self.dogBreed) { response, error in
            DispatchQueue.main.async {
                guard let result = response else {
                    // TODO: Show error message
                    return
                }

                self.list = result
                self.collectionView.reloadData()
            }
        }
    }
}

extension DogBreedCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: self.view.bounds.width - 32, height: 400)
    }
}

extension DogBreedCollectionViewController: DogImageCardViewDelegate {
    func didToggleFavorite(_ image: String) {
        Storage.toggleFavorite(image)
        self.loadFavorites()
        self.collectionView.reloadData()
    }
}
