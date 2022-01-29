//
//  DogServiceApi.swift
//  Dog Breeds
//
//  Created by Vittorio Allegra on 29/01/22.
//

import Foundation

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
}
