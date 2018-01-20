//
//  AppDelegate.swift
//  Waxnation
//
//  Created by Esso AWESSO on 02/12/2017.
//  Copyright © 2017 Esso AWESSO. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseOptions.defaultOptions()?.deepLinkURLScheme = "Waxnation"
        FirebaseApp.configure()
        return true
    }
    
    // [START openurl]
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        return application(app, open: url,
                           sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                           annotation: "")
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if let dynamicLink = DynamicLinks.dynamicLinks()?.dynamicLink(fromCustomSchemeURL: url) {
            // Handle the deep link. For example, show the deep-linked content or
            // apply a promotional offer to the user's account.
            // [START_EXCLUDE]
            // In this sample, we just open an alert.
            handleDynamicLink(dynamicLink)
            // [END_EXCLUDE]
            return true
        }
        // [START_EXCLUDE silent]
        // Show the deep link that the app was called with.
        showDeepLinkAlertView(withMessage: "openURL:\n\(url)")
        // [END_EXCLUDE]
        return false
    }
    // [END openurl]
    
    // [START continueuseractivity]
    func application(_ application: UIApplication, continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        guard let dynamicLinks = DynamicLinks.dynamicLinks() else {
            return false
        }
        let handled = dynamicLinks.handleUniversalLink(userActivity.webpageURL!) { (dynamiclink, error) in
            // [START_EXCLUDE]
            
            if let urlString = dynamiclink?.url?.absoluteString {
                if let itemId = self.getQueryStringParameter(url: urlString, param: "itemId") {
                    FirebaseManager.shared.item(with: itemId, success: { (item) in
                        let detailsViewController = UIStoryboard.detailsViewController()
                        detailsViewController.item = item
                        let rootViewController = self.window?.rootViewController as! UINavigationController
                        rootViewController.pushViewController(detailsViewController, animated: false)
                    }, failure: { (error) in
                        print(error ?? "Error")
                    })
                }
            }
            
            
            
            print(dynamiclink)
            
            // [END_EXCLUDE]
        }
        
        // [START_EXCLUDE silent]
        if !handled {
            // Show the deep link URL from userActivity.
            let message = "continueUserActivity webPageURL:\n\(userActivity.webpageURL?.absoluteString ?? "")"
            showDeepLinkAlertView(withMessage: message)
        }
        // [END_EXCLUDE]
        return handled
    }
    // [END continueuseractivity]
    
    func handleDynamicLink(_ dynamicLink: DynamicLink) {
        let matchConfidence: String
        if dynamicLink.matchConfidence == .weak {
            matchConfidence = "Weak"
        } else {
            matchConfidence = "Strong"
        }
        let message = "App URL: \(dynamicLink.url?.absoluteString ?? "")\n" +
        "Match Confidence: \(matchConfidence)\nMinimum App Version: \(dynamicLink.minimumAppVersion ?? "")"
        showDeepLinkAlertView(withMessage: message)
    }
    
    func getQueryStringParameter(url: String, param: String) -> String? {
        guard let url = URLComponents(string: url) else { return nil }
        return url.queryItems?.first(where: { $0.name == param })?.value
    }
    
    func showDeepLinkAlertView(withMessage message: String) {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let alertController = UIAlertController(title: "Deep-link Data", message: message, preferredStyle: .alert)
        alertController.addAction(okAction)
        self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }

}
