//
//  ViewController.swift
//  TopShop
//
//  Created by Micky on 05/12/2017.
//  Copyright © 2017 Micky. All rights reserved.
//

import UIKit

class LoginViewController: UIScrollViewController {
    
    // MARK: - Properties
    private struct InputErrorMessage {
        static let emptyFields = "Empty fields"
        static let incorrectEmail = "Email is not correct"
        static let wrongPassword = "Wrong password"
    }
    
    private struct SegueID {
        static let showCatalog = "ShowCatalog"
        static let showSignUp = "ShowSignUp"
    }
    
    private struct ImageName {
        static let showPassword = "eye"
        static let hidePassword = "no-eye"
    }
    
    private let authManager = Auth.shared
    
    func switchShowPassworButtonImage() {
        let imageName = passwordTextField.isSecureTextEntry ? ImageName.showPassword : ImageName.hidePassword
        let image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        showPasswordButton.setImage(image, for: .normal)
    }
    
    private func authenticateUser() {
        guard
            let email = emailTextField?.text, !email.isEmpty,
            let password = passwordTextField?.text, !password.isEmpty
        else {
            showErrorMessage(InputErrorMessage.emptyFields)
            return
        }
        if let error = authManager.logIn(withEmail: email, andPass: password) {
            switch error {
            case .unregisteredEmail:
                showErrorMessage(InputErrorMessage.incorrectEmail)
            case .wrongPassword:
                showErrorMessage(InputErrorMessage.wrongPassword)
            }
            passwordTextField.text = ""
        }
    }
    
    private func showErrorMessage(_ message: String) {
        errorMessageLabel.text = message
        errorMessageLabel.isHidden = false
//        passwordTextField.indicateWrongInput()
    }
    
    private func clearInputFields() {
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    // MARK: - Outlets
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var showPasswordButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var contentScrollView: UIScrollView?
    
    // MARK: - Actions
    @IBAction func touchShowPW(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        switchShowPassworButtonImage()
    }
    
    @IBAction func hideKeyboard(_ sender: Any) {
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView = contentScrollView
        prepareUI()
    }
    
    func prepareUI() {
        loginButton?.rounded()
        signupButton?.rounded()
        switchShowPassworButtonImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clearInputFields()
        errorMessageLabel.isHidden = true
        quickIn() // test
    }
    
    func quickIn() {
        emailTextField.text = "t@s.t"
        passwordTextField.text = "Qwert1"
    }
    
    // MARK: - Navigation
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        switch identifier {
        case SegueID.showCatalog:
            authenticateUser()
            return authManager.isUserLoggedIn()
        default:
            return true
        }
    }
}














