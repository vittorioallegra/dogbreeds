//
//  SearchTableViewDelegate.swift
//  Dog Breeds
//
//  Created by Vittorio Allegra on 29/01/22.
//

import Foundation

protocol SearchTableViewDelegate: AnyObject {
    func didSelectDogBreed(_ breed: String)
}