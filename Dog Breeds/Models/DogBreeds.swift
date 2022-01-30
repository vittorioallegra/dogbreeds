//
//  DogBreeds.swift
//  Dog Breeds
//
//  Created by Vittorio Allegra on 29/01/22.
//

import Foundation

struct DogBreeds: Codable {
    let message: [DogBreed: [DogSubBreed]]
    let status: String
}
