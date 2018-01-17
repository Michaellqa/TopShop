//
//  CatalogViewController.swift
//  TopShop
//
//  Created by Micky on 05/12/2017.
//  Copyright © 2017 Micky. All rights reserved.
//

//    var products = [Product(name: "TV"), Product(name: "Laptop"), Product(name: "Table")]


import UIKit

class CatalogViewController: UIViewController {
    var products: [Product] = []
    fileprivate var productsInCart = [Product]() {
        didSet {
            if productsInCart.count > 0 {
                activateCartButton()
            } else {
                cartBarItem.isEnabled = false
            }
        }
    }
    private let CellId = "ProductCell"
    private let queryService = QueryService()
    
    // UIWidgets
    @IBOutlet weak var cartBarItem: UIBarButtonItem! {
        didSet {
            let icon = UIImage(named: "cart-v3")?.withRenderingMode(.alwaysTemplate)
            let iconSize = CGRect(origin: CGPoint.zero, size: icon!.size)
            let iconButton = UIButton(frame: iconSize)
            iconButton.tintColor = .white
            iconButton.setBackgroundImage(icon, for: .normal)
            cartBarItem.customView = iconButton
            cartBarItem.isEnabled = false
        }
    }
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
    
    private func activateCartButton() {
        cartBarItem.isEnabled = true
        cartBarItem.customView!.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.8,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 10,
                       options: .curveLinear,
                       animations: {
                        self.cartBarItem.customView!.transform = CGAffineTransform.identity
        })
    }
    
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
        
        updateTableResults()
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        print("updating >>>")
        updateTableResults()
    }
    
    func updateTableResults() {
        queryService.fetch { products in
            self.refreshControl.endRefreshing()
            self.products = products
            self.tableView.reloadData()
        }
    }
}

// Mark: - TableViewDataSource
extension CatalogViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellId) as! JokeTableViewCell
        cell.product = products[indexPath.row]
        return cell
    }
}

// Mark: - TableViewDelegate
extension CatalogViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let addAction = UIContextualAction(style: .normal, title: "Add to cart") { [weak self] (_, _, _) in
            guard let strongSelf = self else {
                print("Error! Item cannot be added")
                return
            }
            let product = strongSelf.products[indexPath.row]
            strongSelf.productsInCart.append(product)
            
        }
        addAction.backgroundColor = #colorLiteral(red: 1, green: 0.6632423401, blue: 0, alpha: 1)
        let swipeActions = UISwipeActionsConfiguration(actions: [addAction])
        swipeActions.performsFirstActionWithFullSwipe = false
        return swipeActions
    }
}









