//
//  User.swift
//  MI-NUR
//
//  Created by Jan Matějka on 25/11/2019.
//  Copyright © 2019 Jan Matějka. All rights reserved.
//

import Foundation

class User {
    var firstname: String = ""
    var lastname: String = ""
    var jobPosition: String = ""
    var companyName: String = ""
    var email: String = ""
    var password: String = ""
    
    init(firstname: String, lastname: String, jobPosition: String, companyName: String, email: String, password: String) {
        self.firstname = firstname
        self.lastname = lastname
        self.jobPosition = jobPosition
        self.companyName = companyName
        self.email = email
        self.password = password
    }
}
