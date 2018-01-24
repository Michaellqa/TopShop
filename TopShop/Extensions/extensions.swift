//
//  extensions.swift
//  TopShop
//
//  Created by Micky on 21/01/2018.
//  Copyright © 2018 Micky. All rights reserved.
//

import UIKit

extension UIButton {
    func rounded() {
        layer.cornerRadius = frame.height / 2
    }
}

extension UIColor {
    static var main: UIColor {
        return UIColor(red: 1, green: 159/255, blue: 0, alpha: 1)
    }
}

extension UITextField {
    func indicateWrongInput() {
        UIView.animate(withDuration: 0.5, animations: {
            self.layer.shadowColor = UIColor.red.cgColor
            self.layer.shadowRadius = 2
            self.layer.shadowOpacity = 1
            self.layer.shadowOffset = CGSize(width: 0, height: 0)
            self.layer.borderColor = UIColor.red.cgColor
        }) { (isFinished) in
            if isFinished {
                UIView.animate(withDuration: 0.5, delay: 2, options: [], animations: {
//                    self.layer.shadowOpacity = 0
//                    self.layer.borderColor = UIColor.lightGray.cgColor
                }, completion: nil)
            }
        }
    }
}

extension UIView {
    static var separatorView: UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }
}
