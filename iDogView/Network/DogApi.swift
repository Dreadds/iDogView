//
//  DogApi.swift
//  iDogView
//
//  Created by Kevin Tito on 7/3/18.
//  Copyright © 2018 Kevin Tito. All rights reserved.
//

import Foundation

class DogApi {
    static let baseurl = "https://api.thedogapi.co.uk"
    
    public static var getDogs: String {
        return "\(baseurl)/v2/dog.php"
    }
}
