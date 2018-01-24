//
//  Auth.swift
//  TopShop
//
//  Created by Micky on 20/01/2018.
//  Copyright © 2018 Micky. All rights reserved.
//

import Foundation

enum LoginError {
    case unregisteredEmail
    case wrongPassword
}

enum SignUpError {
    case incorrectEmail
    case loginIsTaken
    case weakPassword
}

class AUser {
    let name: String
    let email: String
    let password: String
    
    init(name: String, email: String, password: String) {
        self.name = name
        self.email = email
        self.password = password
    }
}

class Auth {
    private let defaults = UserDefaults.standard
    var loggedUser: AUser?
    
    func isUserLoggedIn() -> Bool {
        return loggedUser != nil
    }
    
    func newUser(_ user: AUser) -> SignUpError? {
        guard emailIsCorrect(user.email) else { return .incorrectEmail }
        guard defaults.string(forKey: user.email) == nil else { return .loginIsTaken }
        guard isPasswordValid(user.password) else { return .weakPassword }
        
        let passMd5 = md5(forPassword: user.password)
        defaults.set(passMd5, forKey: user.email)
        defaults.synchronize()
        return nil
    }
    
    func resign() {
        loggedUser = nil
    }
    
    func logIn(withEmail email: String, andPass pass: String) -> LoginError? {
        guard let passMD5 = defaults.string(forKey: email) else { return .unregisteredEmail }
        guard passMD5 == md5(forPassword: pass) else { return .wrongPassword }
        
        print("Signed In")
        loggedUser = AUser(name: "stub", email: email, password: pass)
        return nil
    }
    
    private func md5(forPassword pass: String) -> String {
        // TODO: Encrypting
        return pass
    }
    
    private func emailIsCorrect(_ email: String) -> Bool {
        let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    private func isPasswordValid(_ pass: String) -> Bool{
        guard !pass.isEmpty else { return false }
        
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 6 characters total
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{6,15}")
        return passwordTest.evaluate(with: pass)
    }
    
    private init() { }
    
    static private var auth: Auth?
    static var shared: Auth {
        if auth == nil {
            auth = Auth()
        }
        return auth!
    }
    
}
