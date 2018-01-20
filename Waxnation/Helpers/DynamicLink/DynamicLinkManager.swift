//
//  DynamicLinkManager.swift
//  Waxnation
//
//  Created by Esso AWESSO on 09/12/2017.
//  Copyright © 2017 Esso AWESSO. All rights reserved.
//

import Foundation
import Firebase

class DynamicLinkManager {
    
    static let DYNAMIC_LINK_DOMAIN = "shdh6.app.goo.gl"
    
    static func generateDynamicLinkFor(linkString: String , success:@escaping ((String?) -> Void), failure: ((Error?) -> Void)?){
        // general link params
        var shortLink:String? = nil
        
        guard let link = URL(string: linkString) else {
            let anError = NSError(domain: "Link can not be empty!", code: 30001, userInfo: nil)
            failure?(anError)
            return
        }
        
        let components = DynamicLinkComponents(link: link, domain: DynamicLinkManager.DYNAMIC_LINK_DOMAIN)
        
        let bundleID = "com.waxnation.waxnation"
        // iOS params
        let iOSParams = DynamicLinkIOSParameters(bundleID: bundleID)
        iOSParams.appStoreID = "310633997"
        components.iOSParameters = iOSParams
        
        // Short Link
        let options = DynamicLinkComponentsOptions()
        options.pathLength = .unguessable
        components.options = options
        components.shorten { (shortURL, warnings, error) in
            // Handle shortURL.
            if let error = error {
                print(error.localizedDescription)
                failure?(error)
                return
            }
            shortLink = shortURL?.absoluteString
            success(shortLink)
        }
    }
    
    static func generateInvitationDynamicLinkFor(item itemID: String , success:@escaping ((String?) -> Void), failure: ((Error?) -> Void)?){
        // general link params
        
        let linkString = "https://\(DYNAMIC_LINK_DOMAIN)/item?itemId=\(itemID)"
        generateDynamicLinkFor(linkString: linkString, success: { (shortLink) in
            success(shortLink)
        }) { (error) in
            failure?(error)
        }
    }
}
