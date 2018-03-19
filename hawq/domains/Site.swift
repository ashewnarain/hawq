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
    let address: Address
    var primaryNumber: String?
    var representative: String?
    
    init() {
        address = Address()
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case category
        case address
        case primaryNumber
        case representative
    }
    
    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(category, forKey: .category)
        try container.encode(address, forKey: .address)
        try container.encodeIfPresent(primaryNumber, forKey: .primaryNumber)
        try container.encodeIfPresent(representative, forKey: .representative)
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        address = try values.decode(Address.self, forKey: .address)
        primaryNumber = try values.decodeIfPresent(String.self, forKey: .primaryNumber)
        representative = try values.decodeIfPresent(String.self, forKey: .representative)
    }
    
}
