//
//  ShoppingCart.swift
//  TopShop
//
//  Created by Micky on 21/01/2018.
//  Copyright © 2018 Micky. All rights reserved.
//

import Foundation

struct CartItem {
    let product: Product
    var quantity: Int
}

class ShoppingCart {
    
    private static var cart: ShoppingCart?
    static var shared: ShoppingCart {
        if cart == nil { cart = ShoppingCart() }
        return cart!
    }
    
    private init() {}
    
    private(set) var items: [CartItem] = []
    var isEmpty: Bool {
        return items.count == 0
    }
    
    func add(newProduct: Product) {
        if let productIndex = items.index(where: { $0.product.id == newProduct.id }) {
            items[productIndex].quantity += 1
        } else {
            items.append(CartItem(product: newProduct, quantity: 1))
        }
    }
    
    func total() -> Int {
        var sum = 0
        items.forEach { sum += ($0.product.price ?? 0) * $0.quantity }
        return sum
    }
    
    var numberOfProducts: Int {
        var counter = 0
        items.forEach { counter += $0.quantity }
        return counter
    }
}
