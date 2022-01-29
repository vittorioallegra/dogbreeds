//
//  DogImage.swift
//  Dog Breeds
//
//  Created by Vittorio Allegra on 29/01/22.
//

import Foundation

struct DogImage: Codable {
    let breed: String
    let image: String
    
    init(breed: String, image: String) {
        self.breed = breed
        self.image = image
    }
}
