//
//  QueryService.swift
//  TopShop
//
//  Created by Micky on 19/12/2017.
//  Copyright © 2017 Micky. All rights reserved.
//

import Alamofire
import Foundation

class QueryService {
    
    private var products: [Product] = []
    private let destinationURLString = "https://api.myjson.com/bins/jfqq5"
    
    func alamoHandyFetch(completion: @escaping ([Product]) -> ()) {
        Alamofire.request(destinationURLString).responseData { response in
            if let data = response.value,
                let utf8string = String(data: data, encoding: .utf8),
                let fetchedProducts = [Product].deserialize(from: utf8string) {
                fetchedProducts.forEach({ product in
                    if let product = product {
                        self.products.append(product)
                    }
                })
                completion(self.products)
            } else {
                print("JSON cannot be decoded")
                completion([])
            }
        }
    }
    
    func alamoAutoFetch(completion: @escaping ([Product]) -> ()) {
        Alamofire.request(destinationURLString).responseData { response in
            if let jsonData = response.value,
                let fetchedProducts = try? JSONDecoder().decode([Product].self, from: jsonData) {
                completion(fetchedProducts)
            } else {
                print("JSON cannot be decoded")
                completion([])
            }
        }
    }
    
    func alamoFetch(completion: @escaping ([Product]) -> ()) {
        products.removeAll()
        
        Alamofire.request(destinationURLString).responseJSON { response in
            
            if let json = response.result.value as? [Any] {
                for productItem in json {
                    if let productItem = productItem as? [String:Any] {
                        let product = Product()
                        product.id = productItem["id"] as? Int
                        product.title = productItem["title"] as? String
                        product.description = productItem["description"] as? String
                        product.url = productItem["url"] as? String
                        product.price = productItem["price"] as? Int
                        
                        self.products.append(product)
                    }
                }
            }
            completion(self.products)
        }
    }
    
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
    
    private func updateResults(_ data: Data) {
        var response: [Any]
        products.removeAll()
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as! [Any] //!
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
                product.url = productItem["url"] as? String
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

