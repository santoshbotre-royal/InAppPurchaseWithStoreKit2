//
//  InAppProductListView.swift
//  InAppPurchases
//
//  Created by santoshbo on 13/02/23.
//

import SwiftUI
import StoreKit

struct ProductPurchaseListView: View {
  
  @EnvironmentObject private var storeKitManager: StoreKitManager
  
  var body: some View {
  VStack {
    Text("In-App Purchases")
      .font(.largeTitle)
      .fontWeight(.heavy)
      .padding()
        
    List(storeKitManager.items) { item in
      ProductView(productPurchaseViewModel: ProductPurchaseViewModel(product: item, storeKitManager: storeKitManager))
        .listRowSeparator(.hidden)
    }
    .listStyle(PlainListStyle()) // Capture the leading and trailing white space.
    .listRowBackground(Color.clear)
    .scrollContentBackground(.hidden)
    }
  }
}

struct InAppProductListView_Previews: PreviewProvider {
    static var previews: some View {
      ProductPurchaseListView()
        .environmentObject(StoreKitManager())
    }
}
