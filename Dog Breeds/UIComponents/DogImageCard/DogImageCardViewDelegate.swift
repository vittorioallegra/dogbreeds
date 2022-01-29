//
//  DogImageCardViewDelegate.swift
//  Dog Breeds
//
//  Created by Vittorio Allegra on 29/01/22.
//

import Foundation

protocol DogImageCardViewDelegate: AnyObject {
    func didToggleFavorite(_ image: String)
}
