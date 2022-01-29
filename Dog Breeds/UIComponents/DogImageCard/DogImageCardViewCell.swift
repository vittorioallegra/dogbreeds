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
    
    var image: String = "" { didSet { self.loadImage() } }
    var isFavorite: Bool = false { didSet { self.setFavoriteButtonImage() } }
    
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
        let shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        let cornerRadius: CGFloat = 4
        
        self.layer.borderWidth = 1
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = shadowColor
        
        self.layer.shadowColor = shadowColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = cornerRadius
        self.layer.shadowOffset = CGSize(width: 0, height: cornerRadius)
        
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.clipsToBounds = true
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.layer.cornerRadius = cornerRadius
        self.addSubview(self.imageView)
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        self.setFavoriteButtonImage()
        self.favoriteButton.addTarget(self, action: #selector(self.handleFavoriteButton), for: .touchDown)
        self.favoriteButton.contentVerticalAlignment = .fill
        self.favoriteButton.contentHorizontalAlignment = .fill
        self.favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.favoriteButton)
        NSLayoutConstraint.activate([
            self.favoriteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.favoriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.favoriteButton.widthAnchor.constraint(equalToConstant: 32),
            self.favoriteButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    @IBAction
    func handleFavoriteButton(_ sender: UIButton) {
        self.delegate?.didToggleFavorite(self.image)
    }
    
    func loadImage() {
        if let data = try? Data(contentsOf: URL(string: self.image)!) {
            self.imageView.image = UIImage(data: data)
        }
    }
    
    func setFavoriteButtonImage() {
        self.favoriteButton.setImage(
            UIImage(systemName: self.isFavorite ? "star.fill" : "star"),
            for: .normal
        )
    }
}
