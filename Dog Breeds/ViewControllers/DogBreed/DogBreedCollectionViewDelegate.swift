//
//  DogBreedCollectionViewDelegate.swift
//  Dog Breeds
//
//  Created by Vittorio Allegra on 30/01/22.
//

import Foundation

protocol DogBreedCollectionViewDelegate: AnyObject {
    func setLoading(_ isLoading: Bool)
    func didReceiveError(_ error: Error?)
}
