# In-App Purchase
### In-App Purchase a simple and secure way to purchase digital goods or services in your apps across all Apple platforms, so people can start playing, gaming, reading, and more, right away. 

## Apple has four types of In-App Purchase'S:
- CONSUMABLES: Can be purchased more than one time. Has a specific expire based on consumption, duration, or a business logic.
- NON-CONSUMABLES - Purchase once and use as long as want.
- AUTO-RENEWABLE SUBSCRIPTIONS - For limited duration with auto-renewable feature.
- NON-RENEWABLE SUBSCRIPTIONS - For limited duration without auto-renewable feature. 


## StoreKit
### Use the StoreKit framework to provide the In-App Purchase which promote in-app purchases for content and services
###* StoreKit support iOS 3.0+, iPadOS 3.0+, macOS 10.7+, tvOS 9/0+ and watchOS 6.2+ *###

## Requirement to develop and test In-App Purchase before WWDC - 2022
### Setting up products in App Store Connect can be a lot of work.
### Set up in App Store Connect
 - Configure in-app purchases in App Store Connect by adding details, such as product name, description, price, and availability. Add localizations to ensure that people in regions where your app is available have a seamless purchase experience in their preferred language.
- Workflow for configuring in-app purchases [https://developer.apple.com/help/app-store-connect/configure-in-app-purchase-settings/overview-for-configuring-in-app-purchases]
- Configure/Sign the Agreements, Tax and Banking [https://appstoreconnect.apple.com/agreements/#/] information
- Create an in-app purchase [https://developer.apple.com/help/app-store-connect/manage-consumable-and-non-consumable-in-app-purchases/create-in-app-purchases]
- Add localizations for in-app purchases [https://developer.apple.com/help/app-store-connect/manage-consumable-and-non-consumable-in-app-purchases/view-and-edit-in-app-purchase-information] 

NOTE: These steps are necessary during development and releasing an app with In-App Purchase's.
So you have to have all above steps done before starting you in-app purchase feature development. Let's admit it's tiring and little overwhelming process/setup. 
 
And then magic happend after 12 years, Apple released a StoreKit 2.

## StoreKit 2 released in WWDC-2021 [https://developer.apple.com/videos/play/wwdc2021/10114/]
- Designed with Swift-first principle
- Uses modern Swift-based APIs that make it easy to deliver great in-app purchase experiences.
- As of Xcode 13, the entire in-app purchase workflow can be done by using a StoreKit configuration file.
- Testing purchase flows in the simulator
- Testing purchase flows in unit and UI tests
- Testing locally when no network connection is available
- Transaction failure, renewals, billing issues, promotional offers, sandbox issues can be easily tested and fixed.

# Test your in-app purchase in Xcode locally.

## Resources

### Use Xcode 13 and later and these resources to build in-app purchases with StoreKit 2.
###* Minimum requirements: iOS 16, iPadOS 16, macOS 13, tvOS 16, watchOS 9 *###

## Constraints
### Using StoreKit 2 is not possible with Objective-C
### Support iOS versions before iOS 15.0 onwards only 


## Let's begin
### Step 1: Create "StoreKit Configuration File"
  1. Launch Xcode, then choose File > New > File.
  2. Search for “StoreKit” in the Filter search field. It's in 'Other' category.
  3. Select “StoreKit Configuration File”
  4. Give the name. For this example we name it as 'PurchaseConfiguration', 

In case, you already have a In-App Purchase (IAP's') available for your application on App Store Connect.
You can check tick *Sync this file with an app in App Store Connect* box. 
This will be useful as you already have products defined in App Store Connect that we would like to mirror for local testing.

In our case we don't have any IAP's. 
### Step 2: Go & select the "PurchaseConfiguration" file from project navigator
  1. Click “+” in the bottom left corner in the PurchaseConfiguration File in Xcode.
  2. Select a type of in-app purchase from shown 4 categories of IAP's
  3. Fill the Reference name, Product ID, Price, and At localization details like Display Name and Description.
  
### Step 3: Enable the StoreKit Configuration
  1. Edit Scheme
  2. Go to Run -> Options
  3. Select the "StoreKit Configuration" and select the "PurchaseConfiguration".
   It's only configuration we have for our application right now.
   

