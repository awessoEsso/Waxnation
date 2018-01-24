//
//  FirebaseManager+Item.swift
//  Waxnation
//
//  Created by Esso AWESSO on 03/12/2017.
//  Copyright © 2017 Esso AWESSO. All rights reserved.
//

import Foundation

extension FirebaseManager {
    func items(with success: @escaping (([Item]) -> Void), failure: ((Error?) -> Void)?) {
        itemReference.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else {
                let anError = NSError(domain: "error occured: can't retreive resources", code: 30001, userInfo: nil)
                failure?(anError)
                return
            }
            var items = [Item]()
            for (key, item) in dictionary {
                if let dict = item as? [String: Any] {
                    let item = Item(identifier: key, dictionary: dict)
                    items.append(item)
                }
            }
            success(items)
        })
    }
    
    func item(with identifier: String, success: @escaping ((Item) -> Void), failure: ((Error?) -> Void)?) {
        itemReference.child(identifier).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else {
                let anError = NSError(domain: "error occured: can't retreive resources", code: 30001, userInfo: nil)
                failure?(anError)
                return
            }
            
            let item = Item(identifier: identifier, dictionary: dictionary)
            success(item)
        }
    }
    
}
