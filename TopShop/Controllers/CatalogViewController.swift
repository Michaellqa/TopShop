//
//  CatalogViewController.swift
//  TopShop
//
//  Created by Micky on 05/12/2017.
//  Copyright © 2017 Micky. All rights reserved.
//

//    var products = [Product(name: "TV"), Product(name: "Laptop"), Product(name: "Table")]


import UIKit
import SwipeCellKit

class CatalogViewController: UIViewController {
    
    var jokes = [Joke(id: 1, content: "lul"),
                 Joke(id: 2, content: "another joke with very very very very deep mining"),
                 Joke(id: 54321, content: "Rofl")]
    fileprivate var productsInCart = [Joke]() {
        didSet {
            if productsInCart.count > 0 {
                print("There are \(productsInCart.count) products in cart")
            } else {
                print("The cart is empty")
            }
        }
    }
    private let CellId = "ProductCell"
    private let queryService = QueryService()
    
    // UIWidgets
    @IBOutlet weak var cartBarItem: UIBarButtonItem! // useless right now
    @IBOutlet weak var profileBarItem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
                                 action: #selector(handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged) // ???
        refreshControl.tintColor = #colorLiteral(red: 1, green: 0.6632423401, blue: 0, alpha: 1)
        return refreshControl
    }()
    
    @IBAction func resignUser(_ sender: UIBarButtonItem) {
        AccountManager.shared.resign()
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.addSubview(refreshControl)
//        tableView.register(JokeTableViewCell.self, forCellReuseIdentifier: CellId) // UNEXPECTED Override registration
        
        updateTableResults() // QueryService test
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        print("updating >>>")
        updateTableResults()
    }
    
    func updateTableResults() {
        queryService.fetch { jokes in
            self.refreshControl.endRefreshing()
            // TODO: should perform after ending
            self.jokes = jokes
            self.tableView.reloadData()
        }
    }
    
    // Mark: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToCart" {
            // if any items were selected...
            print("Let's buy those \(productsInCart.count) products")
        }
    }
}

// Mark: - TableViewDataSource
extension CatalogViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellId) as! JokeTableViewCell
        cell.joke = jokes[indexPath.row]
        cell.delegate = self
        return cell
    }
}

// Mark: - TableViewDelegate
extension CatalogViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        do something...
//        let selectedJoke = jokes[indexPath.row]
//        ...
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration()
    }
}

// Mark: - SwipeCellDelegate
extension CatalogViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
//        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { (action, indexPath) in
//            // handle action by updating model whis deletion
//            self.jokes.remove(at: indexPath.row)
//        }
        let anotherAction = SwipeAction(style: .default, title: "Add to cart") { (action, indexPath) in
            let joke = self.jokes[indexPath.row]
            self.productsInCart.append(joke)
            
            // TODO: Alert controller
            let alert = UIAlertController(title: "Item added to the cart", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        anotherAction.backgroundColor = #colorLiteral(red: 1, green: 0.6632423401, blue: 0, alpha: 1)
        
        return [anotherAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        options.transitionStyle = .drag
//        options.expansionStyle = .destructive // auto-deletion
        return options
    }
}








