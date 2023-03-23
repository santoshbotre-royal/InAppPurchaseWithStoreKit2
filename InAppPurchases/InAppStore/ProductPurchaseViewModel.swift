//
//  ProductPurchaseViewModel.swift
//  InAppPurchases
//
//  Created by santoshbo on 16/02/23.
//

import Foundation
import StoreKit

class ProductPurchaseViewModel {
  let storeKitManager: StoreKitManager
  
  let product: Product
  
  init(product: Product, storeKitManager: StoreKitManager) {
    self.product = product
    self.storeKitManager = storeKitManager
  }
  
  func purchase() {
    Task {
     await storeKitManager.purchase(product)
    }
  }
}
