//
//  ViewController.swift
//  TopShop
//
//  Created by Micky on 05/12/2017.
//  Copyright © 2017 Micky. All rights reserved.
//

import UIKit

class LoginViewController: UIScrollViewController {
    
    private let accountManager = AccountManager.shared
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var contentScrollView: UIScrollView?
    
    @IBAction func touchShowPW(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    @IBAction func hideKeyboard(_ sender: Any) {
        loginTextField.endEditing(true)
        passwordTextField.endEditing(true)
    }
    
    private func authenticateUser() {
        guard let login = loginTextField?.text, !login.isEmpty,
            let password = passwordTextField?.text, !password.isEmpty else {
                showErrorMessage("Empty fields")
                return
        }
        if let error = accountManager.logIn(withLogin: login, password: password) {
            switch error {
            case .unregisteredEmail:
                showErrorMessage("Wrong Email")
            case .wrongPassword:
                showErrorMessage("Wrong Password")
            }
            errorMessageLabel.isHidden = false
        }
    }
    
    private func showErrorMessage(_ message: String) {
        errorMessageLabel.text = message
        errorMessageLabel.isHidden = false
    }
    
    private func clearInputFields() {
        loginTextField.text = ""
        passwordTextField.text = ""
    }
    
    // Mark: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView = contentScrollView
        
        accountManager.conveniencePrintAllUsers()
        // rounded corners for buttons
        loginButton?.layer.cornerRadius = loginButton.frame.height / 2
        signupButton?.layer.cornerRadius = signupButton.frame.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clearInputFields()
        errorMessageLabel.isHidden = true
    }
    
    // Mark: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! { // UNSAFE
        case "ShowSignUp":
            print("sign up segue")
        case "ShowCatalog":
            print("catalog segue")
        default: break
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        switch identifier {
        case "ShowCatalog":
            authenticateUser()
//            return accountManager.isUserAuthenticated()
            print("User info NOT VERIFYING")
            return true
        default: return true
        }
    }
    

}














