//
//  SignUpViewController.swift
//  TopShop
//
//  Created by Micky on 06/12/2017.
//  Copyright © 2017 Micky. All rights reserved.
//

import UIKit

class SignUpViewController: UIScrollViewController {
    
    let authManager = Auth.shared
    
    private struct InputErrorMessage {
        static let emptyFields = "Please fill in all the text fields"
        static let incorrectEmail = "This email is incorrect"
        static let emailIsTaken = "This email is already taken"
        static let weakPassword = "This password is not very strong"
    }

    @IBOutlet weak var navigationBarImageView: UIImageView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var contentScrollView: UIScrollView!
    
    func readDataFromFields() -> (name: String, login: String, password: String)? {
        if let name = nameTextField?.text, !name.isEmpty,
            let login = emailTextField?.text, !login.isEmpty,
            let password = passwordTextField?.text, !password.isEmpty {
            return (name, login, password)
        }
        return nil
    }
    
    @IBAction func hideKeyboard(_ sender: Any) {
        nameTextField.endEditing(true)
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
    }
    
    @IBAction func touchCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func touchSave(_ sender: Any) {
        guard let (name, email, password) = readDataFromFields() else {
            showErrorMessage(InputErrorMessage.emptyFields)
            return
        }
        let user = AUser(name: name, email: email, password: password)
        if let error = authManager.newUser(user) {
            switch error {
            case .incorrectEmail:
                showErrorMessage(InputErrorMessage.incorrectEmail)
            case .loginIsTaken:
                showErrorMessage(InputErrorMessage.emailIsTaken)
            case .weakPassword:
                showErrorMessage(InputErrorMessage.weakPassword)
            }
        } else {
            dismiss(animated: true)
        }
    }
    
    func showErrorMessage(_ message: String) {
        errorMessageLabel.text = message
        errorMessageLabel.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView = contentScrollView
        prepareUI()
    }
    
    func prepareUI() {
        continueButton?.rounded()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

}
