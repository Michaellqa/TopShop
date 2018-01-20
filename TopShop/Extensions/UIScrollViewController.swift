//
//  TextInputViewController.swift
//  TopShop
//
//  Created by Micky on 17/12/2017.
//  Copyright © 2017 Micky. All rights reserved.
//

import UIKit

class UIScrollViewController: UIViewController {
    
    var scrollView: UIScrollView?
    private var keyboardIsHidden = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addKeyboardObservers()
    }
    
    func addKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(UIScrollViewController.keyboardWillShow(_:)),
            name: Notification.Name.UIKeyboardWillShow,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(UIScrollViewController.keyboardWillHide(_:)),
            name: Notification.Name.UIKeyboardWillHide,
            object: nil)
    }
    
    func adjustInsetForKeyboardShow(_ show: Bool, notification: Notification) {
        let userInfo = notification.userInfo ?? [:]
        let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let adjustmentHeight = (keyboardFrame.height + 10) * (show ? 1 : -1)
        scrollView?.contentInset.bottom += adjustmentHeight
        scrollView?.scrollIndicatorInsets.bottom += adjustmentHeight
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        print("show")
        if keyboardIsHidden {
            adjustInsetForKeyboardShow(true, notification: notification)
            keyboardIsHidden = false
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        print("hide")
        adjustInsetForKeyboardShow(false, notification: notification)
        keyboardIsHidden = true
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
