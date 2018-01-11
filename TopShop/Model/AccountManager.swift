//
//  AccountManager.swift
//  TopShop
//
//  Created by Micky on 07/12/2017.
//  Copyright © 2017 Micky. All rights reserved.
//

import Foundation
import CoreData
import UIKit

enum LoginError {
    case unregisteredEmail
    case wrongPassword
}

enum SignUpError {
    case incorrectEmail
    case loginIsTaken
    case weakPassword
}

class AccountManager {
    // MARK: -Singleton
    private static var manager: AccountManager?
    static var shared: AccountManager {
        if manager == nil {
            manager = AccountManager()
        }
        return manager!
    }
    
    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    
    private let entityName = "User"
    private let managedContext: NSManagedObjectContext
    
    private var currentUser: NSManagedObject? {
        didSet {
            if currentUser == nil {
                print("resigned")
            } else {
                let name = currentUser?.value(forKey: "name") ?? "NO NAME"
                print("signed in as \(name)")
            }
        }
    }
    
    func isUserAuthenticated() -> Bool {
        return currentUser != nil
    }
    
    func addUser(name: String, email: String, password: String) -> SignUpError? {
        guard !isUserExist(withLogin: email) else {
            return SignUpError.loginIsTaken
        }
        guard isEmailCorrect(email) else {
            return SignUpError.incorrectEmail
        }
        guard isPasswordStrong(password) else {
            return SignUpError.weakPassword
        }
        
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext)!
        let user = NSManagedObject(entity: entity, insertInto: managedContext)
        user.setValue(name, forKey: "name")
        user.setValue(email, forKey: "email")
        user.setValue(password, forKey: "password")
        do {
            try managedContext.save()
            print("user \(name) was added")
            // optional auto-authentication could be here
        } catch let error as NSError {
            print("Could not save user \(error) \(error.userInfo)")
        }
        return nil
    }
    
    func logIn(withLogin email: String, password: String) -> LoginError? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        do {
            let users = try managedContext.fetch(fetchRequest)
            guard let user = users.first else { return LoginError.unregisteredEmail }
            let passForUserWithThisLogin = user.value(forKey: "password") as! String
            if passForUserWithThisLogin == password {
                currentUser = user
            } else {
                return LoginError.wrongPassword
            }
        } catch let error as NSError {
            print("Could not find user \(error) \(error.userInfo)")
        }
        return nil
    }
    
    func isUserExist(withLogin email: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        if let count = try? managedContext.fetch(fetchRequest).count, count > 0 {
            return true
        }
        return false
    }
    
    func resign() {
        currentUser = nil
    }
    
    func conveniencePrintAllUsers() {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do {
            let users = try managedContext.fetch(fetchRequest)
            for user in users {
                let email = user.value(forKey: "email") as! String
                let pass = user.value(forKey: "password") as! String
                print("Email: \(email) & Pass: \(pass)")
            }
        } catch let error as NSError {
            print("Could not find user \(error) \(error.userInfo)")
        }
    }
    
    // MARK: -Validation
    
    func isEmailCorrect(_ email: String) -> Bool {
        // TODO: email validation
        return email.count > 2
    }
    
    func isPasswordStrong(_ password: String) -> Bool {
        // TODO: password validation
        return password.count > 2
    }
    
    // TODO: invalidate session by time

    // TODO: make authentication easier - get user/pass - return Error?
}
