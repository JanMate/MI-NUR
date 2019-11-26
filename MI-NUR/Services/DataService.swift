//
//  DataService.swift
//  MI-NUR
//
//  Created by Jan Matějka on 25/11/2019.
//  Copyright © 2019 Jan Matějka. All rights reserved.
//

import Foundation

struct DataService {
    static var user = User(firstname: "Jan", lastname: "Matějka", jobPosition: "Software developer", companyName: "Orsia, spol. s.r.o.", email: "matejj32@fit.cvut.cz", password: "")
    
    static var vehicles = [Vehicle]()
    
    static var customers = [Customer]()
    
    static var drives = [Drive]()
    
    static func addVehicle(vehicle: Vehicle) {
        vehicles.append(vehicle)
    }
    
    static func addCustomer(customer: Customer) {
        customers.append(customer)
    }
    
    static func updateUser(user: User) {
        self.user = user
    }
    
    static func addDrive(vehicleIndex: Int, drive: Drive) {
        vehicles[vehicleIndex].drives.append(drive)
        vehicles[vehicleIndex].currentState = drive.stateAfter
        drives.append(drive)
    }
    
    static func getDrivingList(vehicleIndex: Int) -> [Drive] {
        if vehicleIndex < 0 {
            return drives
        } else {
            return vehicles[vehicleIndex].drives
        }
    }
}
