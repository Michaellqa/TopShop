//
//  ProductTableViewCell.swift
//  TopShop
//
//  Created by Micky on 18/01/2018.
//  Copyright © 2018 Micky. All rights reserved.
//

import UIKit
import Kingfisher

class ProductTableViewCell: UITableViewCell {
    
    static let nibName = "ProductTableViewCell"

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var product: Product? { didSet { commonInit() } }
    
    func commonInit() {
        selectionStyle = .none
        if let product = product {
            titleLabel?.text = product.title
            descriptionLabel?.text = product.description
            priceLabel?.text = product.price != nil ? "\(product.price!)p" : "" //!
            
            if let urlString = product.url,
                let imageUrl = URL(string: urlString) {
                thumbnailImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "no-image-available"))
            } else {
                thumbnailImageView.image = UIImage(named: "no-image-available")
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
}
