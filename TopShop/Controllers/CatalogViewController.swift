//
//  CatalogViewController.swift
//  TopShop
//
//  Created by Micky on 05/12/2017.
//  Copyright © 2017 Micky. All rights reserved.
//

import UIKit

class CatalogViewController: UIViewController {
    
    // MARK: - Properties
    private struct Strings {
        static let addAction = "Add to cart"
        static let alertTitle = "Product has been added"
        static let alertDescription = "Product in your shopping cart. Now you can proceed to checkout"
        static let alertAction = "OK"
    }
    
    var products: [Product] = []
    private let cart = ShoppingCart.shared
    private let queryService = QueryService()
    private let cellReuseID = "CatalogProductTVCell"
    
    func updateTableResults(completion: (() -> ())? ) {
        queryService.alamoAutoFetch { [weak self] products in // ---SELF---
            if let strongSelf = self {
                strongSelf.refreshControl.endRefreshing()
                strongSelf.products = products
                strongSelf.tableView.reloadData()
            }
            completion?()
        }
    }
    
    private func activateCartButton() {
        cartBarItem.isEnabled = true
        cartBarItem.customView?.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.8,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 10,
                       options: .curveLinear,
                       animations: {
                        self.cartBarItem.customView!.transform = CGAffineTransform.identity
        })
    }
    
    @objc func handleRefresh() {
        updateTableResults(completion: nil)
    }
    
    
    // MARK: - IBOutlets
    @IBOutlet weak var cartBarItem: UIBarButtonItem! {
        didSet {
            let icon = UIImage(named: "cart-v3")?.withRenderingMode(.alwaysTemplate)
            let iconSize = CGRect(origin: CGPoint.zero, size: icon!.size)
            let iconButton = UIButton(frame: iconSize)
            iconButton.tintColor = .white
            iconButton.setBackgroundImage(icon, for: .normal)
            iconButton.addTarget(self, action: #selector(showCart), for: .touchUpInside)
            cartBarItem.customView = iconButton
            cartBarItem.isEnabled = false
        }
    }
    @IBOutlet weak var loadingBackgroundView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var profileBarItem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
                                 action: #selector(handleRefresh),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.main
        return refreshControl
    }()
    
    //MARK: - IBActions
    @IBAction func resignUser(_ sender: UIBarButtonItem) {
        Auth.shared.resign()
        dismiss(animated: true)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.addSubview(refreshControl)
        tableView.register(UINib(nibName: ProductTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: cellReuseID)
        
        loadingIndicator.startAnimating()
        updateTableResults {
            self.loadingBackgroundView.isHidden = true // ---SELF---
            self.loadingIndicator.stopAnimating()
        }
    }
    
    // MARK: - Navigation
    @objc private func showCart() {
        guard !cart.isEmpty else {
            fatalError("Mismatch UI and model")
        }
        let cartController = CartViewController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(cartController, animated: true)
    }
    
    private func showConfirmationAlert() {
        let alert = UIAlertController(
            title: Strings.alertTitle,
            message: Strings.alertDescription,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: Strings.alertAction, style: .default) { _ in
            self.activateCartButton()
        })
        present(alert, animated: true)
    }
    
}

// Mark: - TableViewDataSource
extension CatalogViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID) as! ProductTableViewCell
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
        let addAction = UIContextualAction(style: .normal, title: Strings.addAction) { [weak self] (_, _, _) in
            guard let strongSelf = self else { return }
            let product = strongSelf.products[indexPath.row]
            strongSelf.cart.add(newProduct: product)
            strongSelf.showConfirmationAlert()
        }
        addAction.backgroundColor = UIColor.main
        let swipeActions = UISwipeActionsConfiguration(actions: [addAction])
        swipeActions.performsFirstActionWithFullSwipe = false
        return swipeActions
    }
    
}
