//
//  CartViewController.swift
//  TopShop
//
//  Created by Micky on 11/12/2017.
//  Copyright © 2017 Micky. All rights reserved.
//

import UIKit

class CartViewController: UICollectionViewController {
    
    // MARK: - Properties
    private let cart = ShoppingCart.shared
    private let navigationTitle = "Cart"
    private let cellReuseID = "CartCell"
    private let headerReuseID = "Header"

    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            collectionView?.contentInsetAdjustmentBehavior = .always
        }
        
        title = navigationTitle
        collectionView?.backgroundColor = .white
        collectionView?.register(CartCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseID)
        collectionView?.register(CartCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuseID)
        
        cartTest()
    }
}

// MARK: - DataSource
extension CartViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cart.items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseID, for: indexPath) as! CartCollectionViewCell
        cell.cartItem = cart.items[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseID, for: indexPath) as! CartCollectionViewHeader
        header.total = cart.total()
        header.numberOfProducts = cart.numberOfProducts
        header.buyDelegate = self
        return header
    }
}

// MARK: - Delegate
extension CartViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: CartCollectionViewCell.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.bounds.width, height: CartCollectionViewHeader.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

// MARK: - BuyDelegate
extension CartViewController: BuyDelegate {
    func buy() {
        let alert = UIAlertController(
            title: "Do you want to buy these products?",
            message: "Money will be debited from your card",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}
// MARK: - Testing
extension CartViewController {
    private func cartTest() {
        let path = Bundle.main.path(forResource: "testCart", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        
        do {
            let data = try Data(contentsOf: url)
            let products = try JSONDecoder().decode([Product].self, from: data)
            for product in products {
                cart.add(newProduct: product)
            }
            cart.add(newProduct: products[0])
        } catch _ { }
    }
}

















