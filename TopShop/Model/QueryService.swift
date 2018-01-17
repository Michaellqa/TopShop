//
//  QueryService.swift
//  TopShop
//
//  Created by Micky on 19/12/2017.
//  Copyright © 2017 Micky. All rights reserved.
//

import UIKit
import Foundation

class QueryService {
    
    var products: [Product] = []
    let destinationURLString = "https://my-json-server.typicode.com/llodi/edustore/products"
    
    func fetch(completion: @escaping ([Product]) -> ()) {
        let session = URLSession(configuration: .default)
        guard let url = constructURL() else {
            return
        }
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print("Fetching data error \(error)")
                return
            }
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let data = data else {
                    print("Server error")
                    return
            }
            self.updateResults(data)
            DispatchQueue.main.async {
                completion(self.products)
            }
        }
        dataTask.resume()
    }
    
    func updateResults(_ data: Data) {
        var response: [Any]
        products.removeAll()
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as! [Any]
        } catch let parseError {
            print("JSONSerialization error \(parseError)")
            return
        }
        
        for productItem in response {
            if let productItem = productItem as? [String:Any] {
                let product = Product()
                product.id = productItem["id"] as? Int
                product.title = productItem["title"] as? String
                product.description = productItem["description"] as? String
                product.imageUrl = productItem["url"] as? String
                product.price = productItem["price"] as? Int
                
                self.products.append(product)
            }
        }
        
    }
    
    func constructURL() -> URL? {
        let urlString = destinationURLString
        guard let url = URL(string: urlString) else {
            return nil
        }
        return url
    }
    
}

