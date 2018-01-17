//
//  JokeTableViewCell.swift
//  TopShop
//
//  Created by Micky on 18/12/2017.
//  Copyright © 2017 Micky. All rights reserved.
//

import UIKit

class JokeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

    var product: Product? {
        didSet {
            guard let product = product else { return }
            idLabel.text = "#\(product.id ?? 0)"
            contentLabel.text = product.title
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


