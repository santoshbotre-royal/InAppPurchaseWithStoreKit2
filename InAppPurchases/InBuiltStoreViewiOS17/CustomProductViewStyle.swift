//
//  CustomProductViewStyle.swift
//  InAppPurchases
//
//  Created by santoshbo on 14/07/23.
//

import SwiftUI
import StoreKit

struct CustomProductViewStyle: ProductViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        switch configuration.state {
        case .success(let product):
            VStack(alignment: .center) {
              configuration.icon
                .padding()
                .background(.cyan)
                .clipShape(Circle())
              Text(product.displayName)
                .font(.largeTitle)
                .foregroundColor(.blue)
              Button(product.displayPrice) {}.tint(.mint)
            }
        case .loading:
          VStack(alignment: .center) {
            Text("Loading...")
          }
        case .unavailable:
          VStack(alignment: .center) {
            Text("Product not available...")
          }
        case .failure(let error):
          VStack(alignment: .center) {
            Text(error.localizedDescription)
          }
        @unknown default:
          Text("Unknown error")
        }
    }
}
