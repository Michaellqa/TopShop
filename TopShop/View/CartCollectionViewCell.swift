//
//  CartCollectionViewCell.swift
//  TopShop
//
//  Created by Micky on 22/01/2018.
//  Copyright © 2018 Micky. All rights reserved.
//

import UIKit

class CartCollectionViewCell: UICollectionViewCell {
    
    var cartItem: CartItem?
    
    private let padding: CGFloat = 8
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .blue
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .red
        label.text = "Title Title"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Price"
        
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.backgroundColor = .green
        return label
    }()
    
    let quantityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .gray
        label.text = "quintity"
        return label
    }()
    
    let stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 8
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.axis = .vertical
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
        setupViews()
        presentData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func presentData() {
        titleLabel.text = cartItem?.product.title
        priceLabel.text = "\(cartItem?.product.price ?? 0)p."
        quantityLabel.text = String(describing: cartItem?.quantity)
    }
    
    func setupViews() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(stack)
        
        stack.addArrangedSubview(priceLabel)
        stack.addArrangedSubview(quantityLabel)

        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: padding).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: padding).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: stack.leadingAnchor, constant: -padding).isActive = true
        
        stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        stack.topAnchor.constraint(equalTo: topAnchor, constant: padding).isActive = true
        stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding).isActive = true
        stack.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
}
