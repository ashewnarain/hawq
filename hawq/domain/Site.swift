//
//  Site.swift
//  hawq
//
//  Created by Anthony Shewnarain on 2/25/18.
//  Copyright © 2018 Anthony Shewnarain. All rights reserved.
//

import Foundation

class Site {
    private var name: String
    private var category: String?
    private var address: Address
    private var primaryNumber: String?
    
    init(name: String, category: String, address: Address, primaryNumber: String) {
        self.name = name
        self.category = category
        self.address = address
        self.primaryNumber = primaryNumber
    }
}
