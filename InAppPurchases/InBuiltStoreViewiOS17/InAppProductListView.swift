//
//  InAppProductListView.swift
//  InAppPurchases
//
//  Created by santoshbo on 12/07/23.
//

import SwiftUI
import StoreKit

struct InAppProductListView: View {
  var products: [ProductInApp]
  var body: some View {
    /// 1. StoreView
    //productListView()
    
    /// 2. ProductView
    //productDetailView()

    /// 3. ProductCustomView
    //productDetailCustomView()
    
    /// 4. Product Design Using ProductViews
    //productDesignUsingProductView()
    
    /// 5. SubscriptionStoreView
    subscriptionStoreView()
  }
  
  @ViewBuilder
  func productListView() -> some View {
    let items = products.map { product in
      product.productID
    }
    /// 1. Default List UI
    //StoreView(ids: items)

    /// 2. Customised UI
    let icons = ["dishtv", "hbo", "disney", "we"]
    StoreView(ids: items) { _ in
      ZStack {
        Image(icons.randomElement() ?? "we")
          .resizable()
          .frame(width: 80, height: 80)
          .padding(.all, 8)
      }
    }.background(.background.secondary)
  }
  
  @ViewBuilder
  func productDetailView() -> some View {
    ProductView(id: "1_week") {
      Image("hbo")
        .productIconBorder()
    }.padding()
    .productViewStyle(.large)
      .background(.background.secondary, in: .rect(cornerRadius: 20))
  }
  
  @ViewBuilder
  func productDetailCustomView() -> some View {
    ProductView(id: "1_week"){
      Image("hbo")
    }.productViewStyle(CustomProductViewStyle())
  }
  
  @ViewBuilder
  func productDesignUsingProductView() -> some View {
    ScrollView {
      VStack(spacing: 10) {
        /// Promotional In-App Purchase Product
        ProductView(id: products.first?.productID ?? "1_week") {
          Image(products.first!.icon)
            .font(.largeTitle)
            .foregroundColor(.blue)
        }
        .padding()
        .background(.background.secondary, in: .rect(cornerRadius: 20))
        .productViewStyle(.large)
      }.scrollClipDisabled()
      
      Divider()
        .padding(.all, 20)
      
      Text("In-App Offers")
        .font(.system(.title, design: .rounded))
        .fontWeight(.semibold)
        .foregroundColor(.orange)
        .frame(maxWidth: .infinity, alignment: .leading)
      
      /// Remaining In-App Products
      ForEach(products, id: \.productID) { product in
        /// Skip 1st in-app as it is already in promoted on top
        if product.productID == "1_week" {
          EmptyView()
        }
        else {
          ProductView(id: product.productID) {
            Image(product.icon)
              .font(.largeTitle)
              .foregroundColor(.blue)
          }
          .padding()
          .background(.gray.opacity(0.1), in: .rect(cornerRadius: 10))
        }
      }
    }
    .contentMargins(.horizontal, 20, for: .scrollContent)
    .scrollIndicators(.hidden)
    .frame(maxWidth: .infinity)
    .background(.background.secondary)
  }
  
  @ViewBuilder
  func subscriptionStoreView() -> some View {
    SubscriptionStoreView(productIDs: StoreKitManager().productIds)
      .subscriptionStorePolicyDestination(url: URL(string: "https://www.google.com")!, for: .privacyPolicy)
      .subscriptionStorePolicyForegroundStyle(.indigo)
      .subscriptionStoreControlBackground(.gradientMaterial)
      .subscriptionStoreButtonLabel(.displayName)
      .subscriptionStoreControlIcon { _,_ in
        Image("hbo")
          .resizable()
          .frame(width:30, height:30)
      }.subscriptionStorePickerItemBackground(.red)
      .subscriptionStoreSignInAction({
        print("go here....")
      })
      
  }
}

#Preview {
  InAppProductListView(products: StoreKitManager().products)
}
