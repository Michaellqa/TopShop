//
//  JokeTableViewCell.swift
//  TopShop
//
//  Created by Micky on 18/12/2017.
//  Copyright © 2017 Micky. All rights reserved.
//

import UIKit
import SwipeCellKit

class JokeTableViewCell: SwipeTableViewCell {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

    var joke: Joke? {
        didSet {
            guard let joke = joke else { return }
            idLabel.text = "#\(joke.id ?? 0)"
            contentLabel.text = joke.content
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


