//
//  SignUpViewController.swift
//  TopShop
//
//  Created by Micky on 06/12/2017.
//  Copyright © 2017 Micky. All rights reserved.
// https://www.raywenderlich.com/159481/uiscrollview-tutorial-getting-started
//

import UIKit

enum Trouble { // rename
    case emptyField
    case badLogin
    case takenLogin
    case weakPassword
}

class SignUpViewController: TextInputViewController {
    
    let manager = AccountManager.shared

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
        guard let (name, login, password) = readDataFromFields() else {
            showErrorMessage("Please fill in all the text fields")
            return
        }
        if let error = manager.addUser(name: name, email: login, password: password) {
            switch error {
            case .incorrectEmail:
                showErrorMessage("This email is incorrect")
            case .loginIsTaken:
                showErrorMessage("This email has already taken")
            case .weakPassword:
                showErrorMessage("This password is too weak")
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
        continueButton?.layer.cornerRadius = continueButton.frame.height / 2
    }

    // MARK: - Navigation

    // TODO: Continue button will autoindicate when your input data is valid

}
