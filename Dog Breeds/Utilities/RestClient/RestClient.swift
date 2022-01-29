//
//  RestClient.swift
//  Dog Breeds
//
//  Created by Vittorio Allegra on 29/01/22.
//

import UIKit

struct RestClient {
    static func dataTask(with url: URL, onCompletion: @escaping (Data?, Error?) -> Void) {
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        
        Self.dataTask(with: request, onCompletion: onCompletion)
    }
    
    static func dataTask(with request: NSMutableURLRequest, onCompletion: @escaping (Data?, Error?) -> Void) {
        print("Executing \(request.httpMethod) request to: \(request.url!.absoluteString)")
        
        let dataTask = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            print("Got response from: \(request.url!.absoluteString)")
            
            guard error == nil else {
                print("Got error with description: \(error!.localizedDescription)")
                onCompletion(nil, error)
                return
            }
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            print("Got status code \(statusCode)")
            guard (HTTPStatus.success.code...299).contains(statusCode) else {
                let httpError = NSError(
                    domain: "RestClient",
                    code: statusCode,
                    userInfo: [NSLocalizedDescriptionKey: HTTPURLResponse.localizedString(forStatusCode: statusCode)]
                )                
                onCompletion(nil, httpError)
                return
            }
            
            if let data = data, let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
                print("Got response object")
                print(jsonObject)
            }
            
            onCompletion(data, nil)
            return
        }
        dataTask.resume()
    }
}
