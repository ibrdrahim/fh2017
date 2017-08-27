//
//  User.swift
//  IosBlueprint
//
//  Created by ibrahim on 11/11/16.
//  Copyright © 2016 Indosytem. All rights reserved.
//

import Foundation

class User {
    let userName:String
    let email:String
    let phone:String
    let balance:String
    
    init(userName:String,email:String,phone:String,balance:String) {
        self.userName = userName
        self.email = email
        self.phone = phone
        self.balance = balance
    }
}
