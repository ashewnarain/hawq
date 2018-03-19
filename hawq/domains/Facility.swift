//
//  Facility.swift
//  hawq
//
//  Created by Anthony Shewnarain on 3/11/18.
//  Copyright © 2018 Anthony Shewnarain. All rights reserved.
//

import Foundation

class Facility: Codable {
    var isHazardFree = 0
    var isLighting = 0
    var isClean = 0
    var isVentilation = 0
    var isCofoPosted = 0
    var isEmergencyExits = 0
    var isFireExtinguisher = 0
    var isFireDrills = 0
    
    init() {}
    
    private enum CodingKeys: String, CodingKey {
        case isHazardFree
        case isLighting
        case isClean
        case isVentilation
        case isCofoPosted
        case isEmergencyExits
        case isFireExtinguisher
        case isFireDrills
    }
    
    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(isHazardFree, forKey: .isHazardFree)
        try container.encode(isLighting, forKey: .isLighting)
        try container.encode(isClean, forKey: .isClean)
        try container.encode(isVentilation, forKey: .isVentilation)
        try container.encode(isCofoPosted, forKey: .isCofoPosted)
        try container.encode(isEmergencyExits, forKey: .isEmergencyExits)
        try container.encode(isFireExtinguisher, forKey: .isFireExtinguisher)
        try container.encode(isFireDrills, forKey: .isFireDrills)
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isHazardFree = try values.decode(Int.self, forKey: .isHazardFree)
        isLighting = try values.decode(Int.self, forKey: .isLighting)
        isClean = try values.decode(Int.self, forKey: .isClean)
        isVentilation = try values.decode(Int.self, forKey: .isVentilation)
        isCofoPosted = try values.decode(Int.self, forKey: .isCofoPosted)
        isEmergencyExits = try values.decode(Int.self, forKey: .isEmergencyExits)
        isFireExtinguisher = try values.decode(Int.self, forKey: .isFireExtinguisher)
        isFireDrills = try values.decode(Int.self, forKey: .isFireDrills)
    }
}
