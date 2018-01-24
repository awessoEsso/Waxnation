//
//  FirebaseManager.swift
//  Waxnation
//
//  Created by Esso AWESSO on 03/12/2017.
//  Copyright © 2017 Esso AWESSO. All rights reserved.
//

import Foundation
import Firebase

class FirebaseManager {
    
    // MARK: Singleton
    static let shared = FirebaseManager()
    let datebaseReference: DatabaseReference
    // MARK: Database References
    lazy var itemReference: DatabaseReference = {
        let itemsRef = self.datebaseReference.child("Item")
        itemsRef.keepSynced(true)
        return itemsRef
    }()
    
    lazy var userReference: DatabaseReference = {
        let itemsRef = self.datebaseReference.child("User")
        itemsRef.keepSynced(true)
        return itemsRef
    }()
    
    // MARK: init method
    init() {
        datebaseReference = Database.database().reference()
    }

}
