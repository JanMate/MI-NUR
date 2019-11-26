//
//  Customer.swift
//  MI-NUR
//
//  Created by Jan Matějka on 25/11/2019.
//  Copyright © 2019 Jan Matějka. All rights reserved.
//

import Foundation

class Customer {
    var name: String = ""
    var street: String = ""
    var city: String = ""
    var zipCode: String = ""
    
    init(name: String, street: String, city: String, zipCode: String) {
        self.name = name
        self.street = street
        self.city = city
        self.zipCode = zipCode
    }
    
}
