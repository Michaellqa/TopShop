//
//  CartViewController.swift
//  TopShop
//
//  Created by Micky on 11/12/2017.
//  Copyright © 2017 Micky. All rights reserved.
//

import UIKit

typealias CartItem = (product: Product, count: Int)

class CartViewController: UIViewController {
    
    var productList = [CartItem]()

    @IBAction func emptyCartButton(_ sender: UIButton) {
        print("Don't do anything")
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Cart"

        for item in productList {
            print("\(item.count) of \(item.product.name)")
        }
    }
    
    
    
    // TODO: - Go out if cart has become empty (annoying UX)

}
