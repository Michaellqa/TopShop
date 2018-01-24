//
//  AppDelegate.swift
//  TopShop
//
//  Created by Micky on 05/12/2017.
//  Copyright © 2017 Micky. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Navigation bar customization
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.2199882269, green: 0.8307816982, blue: 0.8380283117, alpha: 1)
        UINavigationBar.appearance().barStyle = .black
        UIBarButtonItem.appearance().tintColor = .white
        UINavigationBar.appearance().isTranslucent = false
        
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.makeKeyAndVisible()
//        
//        let layout = UICollectionViewFlowLayout()
//        window?.rootViewController = UINavigationController(rootViewController: CartViewController(collectionViewLayout: layout))
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        saveContext()
    }

    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "topShop")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }


}

