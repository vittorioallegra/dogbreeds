//
//  DogImage.swift
//  Dog Breeds
//
//  Created by Vittorio Allegra on 29/01/22.
//

import Foundation

struct DogImage: Codable {
    let breed: DogBreed
    let image: DogImageURL
    
    init(breed: DogBreed, image: DogImageURL) {
        self.breed = breed
        self.image = image
    }
}
