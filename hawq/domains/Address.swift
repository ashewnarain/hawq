//
//  Address.swift
//  hawq
//
//  Created by Anthony Shewnarain on 2/25/18.
//  Copyright © 2018 Anthony Shewnarain. All rights reserved.
//

import Foundation

class Address: Codable {
    var line1: String?
    var line2: String?
    var city: String?
    var state: String?
    var zipCode: String?
    
    init() {
    }
    
    private enum CodingKeys: String, CodingKey {
        case line1
        case line2
        case city
        case state
        case zipCode
    }
    
    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(line1, forKey: .line1)
        try container.encode(line2, forKey: .line2)
        try container.encode(city, forKey: .city)
        try container.encode(state, forKey: .state)
        try container.encode(zipCode, forKey: .zipCode)
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        line1 = try values.decode(String.self, forKey: .line1)
        line2 = try values.decodeIfPresent(String.self, forKey: .line2)
        city = try values.decode(String.self, forKey: .city)
        state = try values.decode(String.self, forKey: .state)
        zipCode = try values.decode(String.self, forKey: .zipCode)
    }
}
