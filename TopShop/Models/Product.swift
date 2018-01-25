//
//  Product.swift
//  TopShop
//
//  Created by Micky on 17/01/2018.
//  Copyright © 2018 Micky. All rights reserved.
//

import Foundation
import HandyJSON

class Product: HandyJSON, Codable {
    var id: Int?
    var title: String?
    var description: String?
    var url: String?
    var price: Int?
    
    required init() { }
    
    init(id: Int, title: String, description: String, imageUrl: String, price: Int) {
        self.id = id
        self.title = title
        self.description = description
        self.url = imageUrl
        self.price = price
    }
}


