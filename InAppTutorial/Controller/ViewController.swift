//
//  ViewController.swift
//  InAppTutorial
//
//  Created by futurino on 16.02.2021.
//

import UIKit
import SwiftyStoreKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var swiftyStore = true
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        if swiftyStore {
            SwiftyStoreKit.retrieveProductsInfo([IAPProduct.product1.rawValue, IAPProduct.product2.rawValue]) { result in
                if let product = result.retrievedProducts.first {
                    let priceString = product.localizedPrice!
                    print("Product: \(product.localizedDescription), price: \(priceString)")
                }
                else if let invalidProductId = result.invalidProductIDs.first {
                    print("Invalid product identifier: \(invalidProductId)")
                }
                else {
                    print("Error: \(result.error)")
                }
            }
        }
        else{
            IAPService.shared.getProducts()
        }

        
    }
    
    
    func buyStoreKit(product : String){
        
        SwiftyStoreKit.purchaseProduct(product, quantity: 1, atomically: false) { result in
            switch result {
            case .success(let product):
                // fetch content from your server, then:
                if product.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(product.transaction)
                }
                print("Purchase Success: \(product.productId)")
            case .error(let error):
                switch error.code {
                case .unknown: print("Unknown error. Please contact support")
                case .clientInvalid: print("Not allowed to make the payment")
                case .paymentCancelled: break
                case .paymentInvalid: print("The purchase identifier was invalid")
                case .paymentNotAllowed: print("The device is not allowed to make the payment")
                case .storeProductNotAvailable: print("The product is not available in the current storefront")
                case .cloudServicePermissionDenied: print("Access to cloud service information is not allowed")
                case .cloudServiceNetworkConnectionFailed: print("Could not connect to the network")
                case .cloudServiceRevoked: print("User has revoked permission to use this cloud service")
                default: print((error as NSError).localizedDescription)
                }
            }
        }
    }
   
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        if swiftyStore {
            
        }
        else{
            if indexPath.row == 0 {
                cell.textLabel?.text = IAPProduct.product1.rawValue
            }else if indexPath.row == 1 {
                cell.textLabel?.text = IAPProduct.product2.rawValue
            }
        }
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if swiftyStore {
            
            if indexPath.row == 0 {
                buyStoreKit(product: IAPProduct.product1.rawValue)
            }
            else if indexPath.row == 1 {
                buyStoreKit(product: IAPProduct.product2.rawValue)
            }
        
        }
        else{
            if indexPath.row == 0 {
                DispatchQueue.main.async {
                    print("first item purchasing")
                    IAPService.shared.purchase(product: .product1)
                }
            }
            else if indexPath.row == 1 {
                DispatchQueue.main.async {
                    print("second item purchasing")
                    IAPService.shared.purchase(product: .product2)
                }
            }
        }

        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    
}



