//
//  HTTPStatus.swift
//  Dog Breeds
//
//  Created by Vittorio Allegra on 29/01/22.
//

import Foundation

enum HTTPStatus: Int {
    case success = 200
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    
    var code: Int {
        return self.rawValue
    }
}
