//
//  Drive.swift
//  MI-NUR
//
//  Created by Jan Matějka on 25/11/2019.
//  Copyright © 2019 Jan Matějka. All rights reserved.
//

import Foundation

class Drive {
    var startDate: String = ""
    var endDate: String = ""
    var duration: Int
    var vehicle: Vehicle
    var isBusiness: Bool
    var customer: Customer
    var from: String = ""
    var to: String = ""
    var distance: Int = 0
    var stateBefore: Int = 0
    var stateAfter: Int = 0
    
    init(startDate: String, endDate: String, duration: Int, vehicle: Vehicle, isBusiness: Bool, customer: Customer, from: String, to: String, distance: Int, stateBefore: Int, stateAfter: Int) {
        self.startDate = startDate
        self.endDate = endDate
        self.duration = duration
        self.vehicle = vehicle
        self.isBusiness = isBusiness
        self.customer = customer
        self.from = from
        self.to = to
        self.distance = distance
        self.stateBefore = stateBefore
        self.stateAfter = stateAfter
    }
    
    func toString() -> String {
        return "\(startDate), \(from), \(to), \(distance) km"
    }
}
