//
//  ProductView.swift
//  InAppPurchases
//
//  Created by santoshbo on 16/02/23.
//

import SwiftUI
import StoreKit

struct ProductItemView: View {
  @EnvironmentObject private var storeKitManager: StoreKitManager
  let productPurchaseViewModel: ProductPurchaseViewModel
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 25, style: .continuous)
        .fill(LinearGradient(gradient:
                              Gradient(colors: [.pink, .purple, .blue]),
                             startPoint: .topLeading,
                             endPoint: .bottomTrailing))
      
      HStack(alignment: .center) {
        VStack(alignment: .leading) {
          
          Text(productPurchaseViewModel.product.displayName)
            .font(.title2)
            .fontWeight(.semibold)
            .padding([.leading, .bottom, .top])
          
          Text(productPurchaseViewModel.product.description)
            .multilineTextAlignment(.leading)
            .fontWeight(.regular)
            .padding(.leading)
          
        }.padding(.bottom)
        
        Spacer()
        
        Button(action: {
          /// Purchase action
          productPurchaseViewModel.purchase()
        }, label: {
          Text("\(productPurchaseViewModel.product.displayPrice)")
            .foregroundColor(.white)
        })
        .tint(.cyan)
        .font(.title3)
        .buttonStyle(.borderedProminent)
          .padding()

      }
    }
  }
}

//struct ProductView_Previews: PreviewProvider {
//  let product = StoreKitManager().items[0]
//
//    static var previews: some View {
//      ProductView(productPurchaseViewModel: ProductPurchaseViewModel(product: product, storeKitManager: StoreKitManager()))
//    }
//}
