//
//  MoviesViewModel.swift
//  InAppPurchases
//
//  Created by santoshbo on 15/02/23.
//

import Foundation
import Combine

class MoviesViewModel: ObservableObject {

  @Published private(set) var storeKitManager: StoreKitManager

  @Published private(set) var status: String = "Unknown"
  @Published var transactionStatus: Bool = false
  private var cancellable: Set<AnyCancellable> = []
  
  init(storeKitManger: StoreKitManager) {
    self.storeKitManager = storeKitManger

    storeKitManager.$transactionCompletionStatus.sink(receiveValue: { result in
      self.transactionStatus = result
    }).store(in: &cancellable)
    
  }

  func purchaseStatus() -> String {
    switch storeKitManager.purchaseStatus {
    case .success(let productId):
      return ("Successfully purchased : \(productId)")
    case .failed(let error):
      return ("Failed purchase order with error: \(error)")
    case .pending:
      return ("Purchase order pending")
    case .cancelled:
      return ("Purchase order cancelled by user")
    case .unknown:
      return ("Unknown")
    }
  }
}
