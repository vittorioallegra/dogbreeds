//
//  Storage.swift
//  Dog Breeds
//
//  Created by Vittorio Allegra on 29/01/22.
//

import Foundation

struct Storage {
    private static let key = "favorites"
    
    static func getFavorites() -> [String] {
        guard let favorites = UserDefaults.standard.array(forKey: Self.key) as? [String] else {
            return []
        }
        
        return favorites
    }
    
    static func saveFavorite(_ favorite: String) {
        var favorites = Self.getFavorites()
        if !favorites.contains(favorite) {
            favorites.append(favorite)
        }
        UserDefaults.standard.set(favorites, forKey: Self.key)
        UserDefaults.standard.synchronize()
    }
}
