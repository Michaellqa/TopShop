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
    
    var jokes: [Joke] = []
    
    func fetch(completion: @escaping ([Joke]) -> ()) {
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
                completion(self.jokes)
            }
        }
        dataTask.resume()
    }
    
    func updateResults(_ data: Data) {
        var response: [String:Any]
        jokes.removeAll()
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
        } catch let parseError {
            print("JSONSerialization error \(parseError)")
            return
        }
        guard let array = response["value"] as? [Any] else {
            print("JSON does not contain value key")
            return
        }
        
        for jokeItem in array {
            if let jokeItem = jokeItem as? [String:Any],
                let jokeID = jokeItem["id"] as? Int,
                let jokeContent = jokeItem["joke"] as? String {
                
                self.jokes.append(Joke(id: jokeID, content: jokeContent))
            }
        }
        
    }
    
    func constructURL() -> URL? {
        let numberOfJokes = 10
        let urlString = "https://api.icndb.com/jokes/random/\(numberOfJokes)"
        guard let url = URL(string: urlString) else {
            return nil
        }
        return url
    }
    
}

