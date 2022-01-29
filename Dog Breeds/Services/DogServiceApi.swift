//
//  DogServiceApi.swift
//  Dog Breeds
//
//  Created by Vittorio Allegra on 29/01/22.
//

import UIKit

struct DogServiceApi {
    static let baseURL = "https://dog.ceo/api"
    
    static func getDogBreeds(_ completion: @escaping ([String]?, Error?) -> Void) {
        let url = URL(string: "\(Self.baseURL)/breeds/list/all")!
        
        RestClient.dataTask(with: url) { result, error in
            guard let result = result,
                  let dogBreeds = try? JSONDecoder().decode(DogBreeds.self, from: result) else {
                completion(nil, error)
                return
            }

            completion(dogBreeds.message.keys.sorted(), nil)
        }
    }
    
    static func getDogBreedImages(dogBreed: String, _ completion: @escaping ([String]?, Error?) -> Void) {
        let url = URL(string: "\(Self.baseURL)/breed/\(dogBreed)/images/random/10")!
        
        RestClient.dataTask(with: url) { result, error in
            guard let result = result,
                  let dogBreedImages = try? JSONDecoder().decode(DogBreedImages.self, from: result) else {
                completion(nil, error)
                return
            }

            completion(dogBreedImages.message, nil)
        }
    }
}
