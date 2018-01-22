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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = navigationTitle
        collectionView?.backgroundColor = .white
        collectionView?.register(CartCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseID)
//        collectionView.regi
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseID, for: indexPath) as! CartCollectionViewCell
        return cell
    }
    
    
    
}

extension CartViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: 100)
    }
}

















