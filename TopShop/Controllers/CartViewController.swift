//
//  CartViewController.swift
//  TopShop
//
//  Created by Micky on 11/12/2017.
//  Copyright © 2017 Micky. All rights reserved.
//

import UIKit

class CartViewController: UICollectionViewController {
    
    private let cart = ShoppingCart.shared
    private let navigationTitle = "Cart"
    private let cellReuseID = "CartCell"
    private let headerReuseID = "Header"

    func cartTest() {
        let iphone = Product(id: 1, title: "iPhone 7", description: "", imageUrl: "", price: 35000)
        let samsung = Product(id: 2, title: "Samsung S8", description: "", imageUrl: "", price: 45000)
        cart.add(newProduct: iphone)
        cart.add(newProduct: iphone)
        cart.add(newProduct: samsung)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = navigationTitle
        collectionView?.backgroundColor = .white
        collectionView?.register(CartCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseID)
        collectionView?.register(CartCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuseID)
        
//        cartTest()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cart.items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseID, for: indexPath) as! CartCollectionViewCell
        cell.cartItem = cart.items[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseID, for: indexPath)
        return header
    }
    
}

extension CartViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.bounds.width, height: 100)
    }
}

















