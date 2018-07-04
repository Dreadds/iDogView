//
//  Dog.swift
//  iDogView
//
//  Created by Kevin Tito on 7/3/18.
//  Copyright © 2018 Kevin Tito. All rights reserved.
//

import Foundation
import SwiftyJSON

class Dog {
    var id: String
    var url: String
    var time: String
    var format: String
    var verified: String
    var checked: String
    
    init(id: String, url: String, time: String, format: String, verified: String, checked: String) {
        self.id = id
        self.url = url
        self.time = time
        self.format = format
        self.verified = verified
        self.checked = checked
    }
    
    convenience init (jsonDog: JSON) {
        self.init(id: jsonDog["id"].stringValue,
                  url: jsonDog["url"].stringValue,
                  time: jsonDog["time"].stringValue,
                   format: jsonDog["format"].stringValue,
                  verified: jsonDog["verified"].stringValue,
                  checked: jsonDog["checked"].stringValue)
    }
    //Favorites
    func isFavorite() -> Bool {
        let store = iDogStore()
        return store.isFavorite(dog: self)
    }
    
    func setFavorite(isFavorite: Bool){
        let store = iDogStore()
        store.setFavorite(isFavorite, for: self)
    }
    
    //json
    static func buildAll(from jsonDogs: [JSON]) -> [Dog] {
        var dogs: [Dog] = []
        let count = jsonDogs.count
        for i in 0 ..< count {
            dogs.append(Dog(jsonDog: jsonDogs[i]))
        }
        return dogs
    }
}

