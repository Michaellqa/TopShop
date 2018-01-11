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
            buyButtonIsActive = (productsInCart.count == 0) ? false : true
        }
    }
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
                                 action: #selector(handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged) // ???
        refreshControl.tintColor = .red
        
        return refreshControl
    }()
    
    private let CellId = "ProductCell"
    private let queryService = QueryService()
    
    @IBOutlet weak var profileBarItem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buyButton: UIButton!
    
    @IBAction func resignUser(_ sender: UIBarButtonItem) {
        AccountManager.shared.resign()
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.addSubview(refreshControl)
        
//        tableView.register(JokeTableViewCell.self, forCellReuseIdentifier: CellId) // ????
        
        buyButtonIsActive = false
        
        // QueryService test
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
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        print("updating >>>")
        updateTableResults()
    }
    
    // Mark: - UI & Animation
    
    @IBOutlet weak var buttonBottomConstrain: NSLayoutConstraint!
    
    private var buyButtonIsActive: Bool = true {
        didSet {
            buttonBottomConstrain.constant = buyButtonIsActive ? 0 : -buyButton.bounds.height
            buyButton.isEnabled = buyButtonIsActive
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    // Mark: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToCheckout" {
            print("Preparation is stubbing")
        }
    }
}

// Mark: - DataSource
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

// Mark: - Delegate
extension CatalogViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedJoke = jokes[indexPath.row]
        productsInCart.append(selectedJoke)
        print(selectedJoke.id!)
        // TODO: here items should be added to the cart
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        return UISwipeActionsConfiguration()
    }
    
}

extension CatalogViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // handle action by updating model whis deletion
            self.jokes.remove(at: indexPath.row)
        }
        let anotherAction = SwipeAction(style: .default, title: "Info") { (action, indexPath) in
            // add to shopping cart
            let joke = self.jokes[indexPath.row]
            self.productsInCart.append(joke)
        }
        return [deleteAction, anotherAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        options.transitionStyle = .drag
        options.expansionStyle = .destructive // auto-deletion
        return options
    }
    
}

//extension CatalogViewController: SwipeExpanding {
//    func animationTimingParameters(buttons: [UIButton], expanding: Bool) -> SwipeExpansionAnimationTimingParameters {
//        <#code#>
//    }
//    
//    func actionButton(_ button: UIButton, didChange expanding: Bool, otherActionButtons: [UIButton]) {
//        <#code#>
//    }
//    
//    
//}








