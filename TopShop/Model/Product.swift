//
//  Product.swift
//  TopShop
//
//  Created by Micky on 17/01/2018.
//  Copyright © 2018 Micky. All rights reserved.
//

import Foundation

class Product {
    var id: Int?
    var title: String?
    var description: String?
    var imageUrl: String?
    var price: Int?
    
    init() {
        
    }
    
    init(id: Int, title: String, description: String, imageUrl: String, price: Int) {
        self.id = id
        self.title = title
        self.description = description
        self.imageUrl = imageUrl
        self.price = price
    }
}
