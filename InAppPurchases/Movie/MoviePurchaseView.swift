//
//  MoviePurchaseView.swift
//  InAppPurchases
//
//  Created by santoshbo on 13/02/23.
//

import SwiftUI
import StoreKit

struct MoviePurchaseView: View {
  
  @State var presentedInAppPurchaseModal: Bool = false
  @StateObject var moviesViewModel: MoviesViewModel
  
  var body: some View {
    VStack {
      Image("movie_poster")
        .cornerRadius(10)
      
      Button(action: {
        presentedInAppPurchaseModal.toggle()
      }, label: {
        Text("Buy Now")
          .font(.title2)
          .frame(maxWidth:240)
      })
      .buttonStyle(.borderedProminent)
      .controlSize(.large)
      .sheet(
        isPresented: $presentedInAppPurchaseModal,
        content: {
          if #available(iOS 17, *) {
            InAppProductListView(products: moviesViewModel.storeKitManager.products)
          } else {
            ProductPurchaseListView()
              .environmentObject(moviesViewModel.storeKitManager)
          }
      })

      Text(purchaseStatus())
        .padding()
    }
    .alert("In-App Purchase", isPresented: $moviesViewModel.transactionStatus) {
      Button("OK", role: .cancel) {
        presentedInAppPurchaseModal = false
      }
    } message: {
      let status = moviesViewModel.purchaseStatus()
      Text(status)
    }
  }
  
  private func purchaseStatus() -> String {
    let status = moviesViewModel.purchaseStatus()
    return moviesViewModel.transactionStatus == true ? "Purchase status: \(status)" : "Purchase status: \(status)"
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      MoviePurchaseView(moviesViewModel: MoviesViewModel(storeKitManger: StoreKitManager()))
    }
}
