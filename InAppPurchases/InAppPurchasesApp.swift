//
//  InAppPurchasesApp.swift
//  InAppPurchases
//
//  Created by santoshbo on 13/02/23.
//

import SwiftUI

@main
struct InAppPurchasesApp: App {
  
  let movieViewModel: MoviesViewModel
  
  init() {
    let storeKitManager = StoreKitManager()
    movieViewModel = MoviesViewModel(storeKitManger: storeKitManager)
  }
  
  var body: some Scene {
    WindowGroup {
      MoviePurchaseView(moviesViewModel: movieViewModel)
    }
  }
}
