//
//  Item.swift
//  Waxnation
//
//  Created by Esso AWESSO on 03/12/2017.
//  Copyright © 2017 Esso AWESSO. All rights reserved.
//

import Foundation

class Item {
    var description: String?
    var price: Double?
    var coverImageURL: URL?
    var photos: [URL?]?
    var identifier: String
    
    
    init(description: String, price: Double, coverImageURL: URL, photos: [URL]? = nil) {
        self.description = description
        self.price = price
        self.coverImageURL = coverImageURL
        self.photos = photos
        self.identifier = ""
    }
    
    init(identifier anIdentifier: String, dictionary: [String: Any]) {
        identifier = anIdentifier
        description = dictionary["description"] as? String
        price = dictionary["price"] as? Double
        if let photoURLAbsoluteString = dictionary["coverImageURL"] as? String {
            coverImageURL = URL(string: photoURLAbsoluteString)
        }
        
        if let photosArray = dictionary["photos"] as? [String] {
            var pp = [URL?]()
            for value in photosArray {
                pp.append(URL(string: value))
            }
            self.photos = pp
        }
        
    }
}
