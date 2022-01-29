//
//  DogImageCardViewCell.swift
//  Dog Breeds
//
//  Created by Vittorio Allegra on 29/01/22.
//

import UIKit

class DogImageCardViewCell: UICollectionViewCell {
    var delegate: DogImageCardViewDelegate?
    
    static let reuseIdentifier = "DogImageCardView"
    
    private let imageView = UIImageView()
    private let favoriteButton = UIButton()
    private let breedLabel = DogImageCardLabel()
    
    private let shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
    private let cornerRadius: CGFloat = 4
    private let padding: CGFloat = 16
    
    var dog: DogImage? { didSet { self.loadImage() } }
    var isFavorite: Bool = false { didSet { self.setFavoriteButtonImage() } }
    var showLabel: Bool = false { didSet { self.toggleBreedLabel() } }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initView()
    }
}

private extension DogImageCardViewCell {
    func initView() {
        self.layer.borderWidth = 1
        self.layer.cornerRadius = self.cornerRadius
        self.layer.borderColor = self.shadowColor
        
        self.layer.shadowColor = self.shadowColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = self.cornerRadius
        self.layer.shadowOffset = CGSize(width: 0, height: self.cornerRadius)
        
        self.addImageView()
        self.addFavoriteButton()
        self.addBreedLabel()
    }
    
    func addImageView() {
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.clipsToBounds = true
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.layer.cornerRadius = self.cornerRadius
        self.addSubview(self.imageView)
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    func addFavoriteButton() {
        self.setFavoriteButtonImage()
        self.favoriteButton.addTarget(self, action: #selector(self.handleFavoriteButton), for: .touchDown)
        self.favoriteButton.contentVerticalAlignment = .fill
        self.favoriteButton.contentHorizontalAlignment = .fill
        self.favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.favoriteButton)
        NSLayoutConstraint.activate([
            self.favoriteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: self.padding),
            self.favoriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -self.padding),
            self.favoriteButton.widthAnchor.constraint(equalToConstant: self.padding * 2),
            self.favoriteButton.heightAnchor.constraint(equalToConstant: self.padding * 2)
        ])
    }
    
    func addBreedLabel() {
        self.breedLabel.translatesAutoresizingMaskIntoConstraints = false
        self.breedLabel.clipsToBounds = true
        self.breedLabel.layer.cornerRadius = self.cornerRadius
        self.breedLabel.textColor = .black
        self.breedLabel.backgroundColor = .white
        self.breedLabel.isHidden = true
        self.addSubview(self.breedLabel)
        NSLayoutConstraint.activate([
            self.breedLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.breedLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.breedLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.breedLabel.heightAnchor.constraint(equalToConstant: self.padding * 3)
        ])
    }
    
    @IBAction
    func handleFavoriteButton(_ sender: UIButton) {
        if let dog = self.dog {
            self.delegate?.didToggleFavorite(dog)
        }
    }
    
    func loadImage() {
        guard let dog = self.dog else {
            return
        }
        
        self.breedLabel.text = dog.breed
        if let data = try? Data(contentsOf: URL(string: dog.image)!) {
            self.imageView.image = UIImage(data: data)
        }
    }
    
    func setFavoriteButtonImage() {
        self.favoriteButton.setImage(
            UIImage(systemName: self.isFavorite ? "star.fill" : "star"),
            for: .normal
        )
    }
    
    func toggleBreedLabel() {
        self.breedLabel.isHidden = !self.showLabel
    }
}
