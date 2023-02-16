//
//  StoreKitManager.swift
//  InAppPurchases
//
//  Created by santoshbo on 13/02/23.
//

import Foundation
import StoreKit

enum StoreKitError: Error {
  case failedVerification
  case unknownError
}

enum PurchaseStatus {
  case success(String)
  case pending
  case cancelled
  case failed(Error)
  case unknown
}

protocol StoreKitManageable {
  func retrieveProducts() async
  func purchase(_ item: Product) async
  func verifyPurchase<T>(_ verificationResult: VerificationResult<T>) throws -> T
  func transactionStatusStream() -> Task<Void, Error>
}

class StoreKitManager: StoreKitManageable, ObservableObject {
  @Published private(set) var items = [Product] ()
  @Published var transactionCompletionStatus : Bool = false
  
  private let productIds = ["1_week", "1_month", "3_months", "1_year"]
  private(set) var purchaseStatus: PurchaseStatus = .unknown
  private(set) var transactionListener: Task<Void, Error>?
  
  init() {
    transactionListener = transactionStatusStream()
    Task {
      await retrieveProducts()
    }
  }
  
  deinit {
    transactionListener?.cancel()
  }
  
  /// Get all of the in-app products
  func retrieveProducts() async {
    do {
      let products = try await Product.products(for: productIds)
      self.items = products.sorted(by: { $0.price < $1.price })
      for product in self.items {
        print("In-App Product:: \(product.displayName) in \(product.displayPrice)")
      }
    } catch {
      print(error)
    }
  }
  
  /// Purchase the in-app product
  func purchase(_ item: Product) async {
    do {
      let result = try await item.purchase()
      
      switch result {
      case .success(let verification):
        print("Purchase was a success, now it can be verified.")
        do {
          let verificationResult = try verifyPurchase(verification)
          purchaseStatus = .success(verificationResult.productID)
          await verificationResult.finish()
          transactionCompletionStatus = true
        } catch {
          purchaseStatus = .failed(error)
          transactionCompletionStatus = true
        }
      case .pending:
        print("Transaction is pending for some action from the users related to the account")
        purchaseStatus = .pending
        transactionCompletionStatus = false
      case .userCancelled:
        print("Use cancelled the transaction")
        purchaseStatus = .cancelled
        transactionCompletionStatus = false
      default:
        print("Unknown error")
        purchaseStatus = .failed(StoreKitError.unknownError)
        transactionCompletionStatus = false
      }
    } catch {
      print(error)
      purchaseStatus = .failed(error)
      transactionCompletionStatus = false
    }
  }
  
  /// Verify Purchase
  func verifyPurchase<T>(_ verificationResult: VerificationResult<T>) throws -> T {
    switch verificationResult {
    case .unverified(_, let error):
      throw error //Successful purchase but transaction/receipt can't be verified due to some conditions like jailbroken phone
    case .verified(let result):
      return result  // Successful purchase
    }
  }
  
  /// Handle Interruptions
  func transactionStatusStream() -> Task<Void, Error> {
    Task.detached(priority: .background) { @MainActor [weak self] in
      do {
        for await result in Transaction.updates {
          let transaction = try self?.verifyPurchase(result)
          self?.purchaseStatus = .success(transaction?.productID ?? "Unknown Product Id")
          self?.transactionCompletionStatus = true
          await transaction?.finish()
        }
      } catch {
        self?.transactionCompletionStatus = true
        self?.purchaseStatus = .failed(error)
      }
    }
  }
  
  /// Unlocking in-app features -
  func inAppEntitlements() async {
    // It return the array of all transactions
    for await result in Transaction.all {
      dump(result.payloadData)
    }
  }
}
