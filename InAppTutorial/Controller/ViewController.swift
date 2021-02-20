//
//  ViewController.swift
//  InAppTutorial
//
//  Created by futurino on 16.02.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        IAPService.shared.getProducts()

        
    }
   
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        if indexPath.row == 0 {
            cell.textLabel?.text = IAPProduct.product1.rawValue
        }else if indexPath.row == 1 {
            cell.textLabel?.text = IAPProduct.product2.rawValue
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

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
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
}



