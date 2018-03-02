//
//  Site.swift
//  hawq
//
//  Created by Anthony Shewnarain on 2/25/18.
//  Copyright © 2018 Anthony Shewnarain. All rights reserved.
//

import Foundation

class Site: Codable {
    var name: String?
    var category: String?
    var address: Address?
    var primaryNumber: String?
    
    init() {}
    
    private enum CodingKeys: String, CodingKey {
        case name
        case category
        case address
        case primaryNumber
    }
    
    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(category, forKey: .category)
        try container.encode(address, forKey: .address)
        try container.encode(primaryNumber, forKey: .primaryNumber)
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        address = try values.decode(Address.self, forKey: .address)
        primaryNumber = try values.decodeIfPresent(String.self, forKey: .primaryNumber)
    }
    
}
