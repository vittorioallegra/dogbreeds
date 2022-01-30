//
//  DogBreedCollectionViewController.swift
//  Dog Breeds
//
//  Created by Vittorio Allegra on 29/01/22.
//

import UIKit

class DogBreedCollectionViewController: UICollectionViewController {
    var delegate: DogBreedCollectionViewDelegate?
    
    private var list: [DogImage] = []
    private let dogBreed: DogBreed
    
    init(dogBreed: DogBreed) {
        self.dogBreed = dogBreed
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.dogBreed.capitalized

        // Register cell classes
        self.collectionView!.register(
            DogImageCardViewCell.self,
            forCellWithReuseIdentifier: DogImageCardViewCell.reuseIdentifier
        )

        self.loadDogBreedImagesList()
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
        return self.list.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DogImageCardViewCell.reuseIdentifier,
            for: indexPath
        ) as! DogImageCardViewCell
        
        let dog = self.list[indexPath.row]
        cell.dog = dog
        cell.isFavorite = Storage.getFavorites().contains(where: { $0.image == dog.image })
        cell.delegate = self
    
        return cell
    }
}

private extension DogBreedCollectionViewController {
    func loadDogBreedImagesList() {
        self.delegate?.setLoading(true)
        
        DogServiceApi.getDogBreedImages(dogBreed: self.dogBreed) { response, error in
            self.delegate?.setLoading(false)
            
            DispatchQueue.main.async {
                guard let result = response else {
                    self.delegate?.didReceiveError(error)
                    return
                }

                self.list = result.map({ DogImage(breed: self.dogBreed, image: $0) })
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

extension DogBreedCollectionViewController: DogImageCardViewDelegate {
    func didToggleFavorite(_ dog: DogImage) {
        Storage.toggleFavorite(dog)
        self.collectionView.reloadData()
    }
}
