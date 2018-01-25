//
//  CartCollectionViewHeader.swift
//  TopShop
//
//  Created by Micky on 23/01/2018.
//  Copyright © 2018 Micky. All rights reserved.
//

import UIKit

protocol BuyDelegate {
    func buy()
}

class CartCollectionViewHeader: UICollectionViewCell {
    
    //MARK: - Properties
    var numberOfProducts = 0 { didSet { presentData() } }
    var total = 0 { didSet { presentData() } }
    var buyDelegate: BuyDelegate?
    
    private let padding: CGFloat = 8
    
    let totalLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var buyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.main
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Proceed to checkout", for: .normal)
        button.addTarget(self, action: #selector(handleCheckout), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 8)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [totalLabel, buyButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 8
        stack.distribution = .fillProportionally
        stack.alignment = .center
        stack.axis = .vertical
        return stack
    }()
    
    func setupViews() {
        let separator = UIView.separatorView
        addSubview(separator)
        separator.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        separator.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        separator.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: padding).isActive = true
        stackView.bottomAnchor.constraint(equalTo: separator.topAnchor, constant: -padding).isActive = true
        
        totalLabel.widthAnchor.constraint(greaterThanOrEqualTo: widthAnchor, multiplier: 1, constant: -8) .isActive = true
        buyButton.widthAnchor.constraint(greaterThanOrEqualTo: widthAnchor, multiplier: 0.45).isActive = true
        buyButton.layer.cornerRadius = 5
    }
    
    func presentData() {
        totalLabel.text = "Cart subtotal (\(numberOfProducts) items): \(total)₽"
    }
    
    @objc func handleCheckout() {
        buyDelegate?.buy()
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
