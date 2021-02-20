//
//  IAPService.swift
//  futurino-omr-mobile-ios
//
//  Created by futurino on 18.02.2021.
//  Copyright © 2021 Futurino. All rights reserved.
//

import Foundation
import StoreKit

class IAPService: NSObject {
    
    private override init(){}
    static let shared = IAPService()
    
    var products = [SKProduct]()
    let paymentQueue = SKPaymentQueue.default()
    
    
    
    func getProducts()  {
        let products: Set = [IAPProduct.product1.rawValue, IAPProduct.product2.rawValue]
        
        let request = SKProductsRequest(productIdentifiers: products)
        request.delegate = self
        request.start()
        
        paymentQueue.add(self)
    }
    
    func purchase(product : IAPProduct) {
        
        guard let productToPurchase = products.filter({$0.productIdentifier == product.rawValue}).first else { return }
        
        let payment = SKPayment(product: productToPurchase)
        
        paymentQueue.add(payment)
    }
    
}

extension IAPService: SKProductsRequestDelegate {
   
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print(response.products)
        
        self.products = response.products
        print(response)
        
        for product in response.products {
            print(product.localizedTitle)
        }
    }
}

extension IAPService : SKPaymentTransactionObserver {
    
    //Mevcut ödemenin durumunu belirten delegate'dir. Kullanıcı çıktı, vazgeçti, satın aldı gibi bilgileri buradan alıyoruz
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
     
        for transaction in transactions {
            print("asd")
            print(transaction.transactionState)
            print(transaction.transactionState.status(), transaction.payment.productIdentifier)
            
        }
        
        
    }
    
}

extension SKPaymentTransactionState {
    
    func status() -> String {
        switch self {
        case .deferred: return "deferred"
        case .failed:   return "failed"
        case .purchased: return "purchased"
        case .purchasing: return "purchasing"
        case .restored:   return "restored"
        }
    }
}
