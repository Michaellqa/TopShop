//
//  CartCollectionViewCell.swift
//  TopShop
//
//  Created by Micky on 22/01/2018.
//  Copyright © 2018 Micky. All rights reserved.
//

import UIKit
import Kingfisher

class CartCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    var cartItem: CartItem? { didSet { presentData() } }
    
    private struct Constraints {
        static let imageWidth: CGFloat = 50
        static let priceWidth: CGFloat = 70
        static let padding: CGFloat = 8
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title Title"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 2
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Price"
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textAlignment = .center
        return label
    }()
    
    let quantityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.text = "quintity"
        label.textAlignment = .center
        return label
    }()
    
    let stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.axis = .vertical
        return stack
    }()
    
    func presentData() {
        titleLabel.text = cartItem?.product.title
        if let price = cartItem?.product.price {
            priceLabel.text = "\(price)p."
        }
        if let quantity = cartItem?.quantity, quantity > 1 {
            quantityLabel.text = "\(quantity) items"
            quantityLabel.isHidden = false
        } else {
            quantityLabel.isHidden = true
        }
        if let urlString = cartItem?.product.url, let imageUrl = URL(string: urlString) {
            imageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "no-image-avaliable"))
        } else {
            imageView.image = UIImage(named: "no-image-available")
        }
        
    }
    
    func setupViews() {
        let separator = UIView.separatorView
        addSubview(separator)
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(stack)
        
        separator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constraints.padding).isActive = true
        separator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constraints.padding).isActive = true
        separator.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        stack.addArrangedSubview(priceLabel)
        stack.addArrangedSubview(quantityLabel)

        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constraints.padding).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: Constraints.padding).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constraints.padding).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: Constraints.imageWidth).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Constraints.padding).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: stack.leadingAnchor, constant: -Constraints.padding).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constraints.padding).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constraints.padding).isActive = true
        
        stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constraints.padding).isActive = true
        stack.topAnchor.constraint(equalTo: topAnchor, constant: Constraints.padding).isActive = true
        stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constraints.padding).isActive = true
        stack.widthAnchor.constraint(equalToConstant: Constraints.priceWidth).isActive = true
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        presentData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
