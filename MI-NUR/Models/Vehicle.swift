//
//  Vehicle.swift
//  MI-NUR
//
//  Created by Jan Matějka on 25/11/2019.
//  Copyright © 2019 Jan Matějka. All rights reserved.
//

import Foundation

class Vehicle {
    var manufacture: String = ""
    var model: String = ""
    var licensePlate: String
    var color: String
    var currentState: Int
    var consuption: Float
    var year: Int
    
    var drives = [Drive]()
    
    init(manufacture: String, model: String, licensePlate: String, color: String, initState: Int, consuption: Float, year: Int) {
        self.manufacture = manufacture
        self.model = model
        self.licensePlate = licensePlate
        self.color = color
        self.currentState = initState
        self.consuption = consuption
        self.year = year
    }
    
    func toString() -> String {
        return "\(manufacture) \(model), \(color), \(String(year))"
    }
}
