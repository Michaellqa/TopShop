//
//  TextInputViewController.swift
//  TopShop
//
//  Created by Micky on 17/12/2017.
//  Copyright © 2017 Micky. All rights reserved.
//

import UIKit

class UIScrollViewController: UIViewController {
    
    // MARK: - Properties
    var scrollView: UIScrollView?
    
    private var keyboardIsHidden = true
    private let spaceAboveKeyboard: CGFloat = 10
    
    private func addKeyboardObservers() {
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
    
    private func adjustInsetForKeyboardShow(_ show: Bool, notification: Notification) {
        let userInfo = notification.userInfo ?? [:]
        let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let adjustmentHeight = (keyboardFrame.height + spaceAboveKeyboard) * (show ? 1 : -1)
        scrollView?.contentInset.bottom += adjustmentHeight
        scrollView?.scrollIndicatorInsets.bottom += adjustmentHeight
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if keyboardIsHidden {
            adjustInsetForKeyboardShow(true, notification: notification)
            keyboardIsHidden = false
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        adjustInsetForKeyboardShow(false, notification: notification)
        keyboardIsHidden = true
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addKeyboardObservers()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
