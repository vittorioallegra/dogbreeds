//
//  Storage.swift
//  Dog Breeds
//
//  Created by Vittorio Allegra on 29/01/22.
//

import Foundation

struct Storage {
    private static let key = "favorites"
    
    static func getFavorites() -> [DogImage] {
        guard let data = UserDefaults.standard.data(forKey: Self.key),
              let favorites = try? JSONDecoder().decode([DogImage].self, from: data) else {
            return []
        }
        
        return favorites
    }
    
    static func toggleFavorite(_ dog: DogImage) {
        var favorites = Self.getFavorites()
        if favorites.contains(where: { $0.image == dog.image }) {
            favorites.removeAll(where: { $0.image == dog.image })
        } else {
            favorites.append(dog)
        }
        
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: Self.key)
            UserDefaults.standard.synchronize()
        }
    }
}
