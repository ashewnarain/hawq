//
//  Address.swift
//  hawq
//
//  Created by Anthony Shewnarain on 2/25/18.
//  Copyright © 2018 Anthony Shewnarain. All rights reserved.
//

import Foundation

class Address {
    private var addressLine1: String
    private var addressLine2: String?
    private var city: String
    private var state: String
    private var zipCode: String
    
    init (addressLine1: String, addressLine2: String?, city: String, state: String, zipCode: String) {
        self.addressLine1 = addressLine1
        self.addressLine2 = addressLine2
        self.city = city
        self.state = state
        self.zipCode = zipCode
    }
}
