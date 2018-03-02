//
//  PreAssessment.swift
//  hawq
//
//  Created by Anthony Shewnarain on 2/25/18.
//  Copyright © 2018 Anthony Shewnarain. All rights reserved.
//

import Foundation

class PreAssessment: BaseEvaluation {
    var site: Site?
    var facilityHazardFree = 0
    var facilityLighting = 0
    var facilityClean = 0
    var facilityVentilation = 0
    var facilityCofoPosted = 0
    var facilityEmergencyExits = 0
    var facilityFireExtinguisher = 0
    var facilityFireDrills = 0
    
    init(evaluator: Person, site: Site) {
        super.init(type: .PreAssessment, evaluator: evaluator)
        self.site = site
    }
    
    private enum CodingKeys: String, CodingKey {
        case site
        case facilityHazardFree
        case facilityLighting
        case facilityClean
        case facilityVentilation
        case facilityCofoPosted
        case facilityEmergencyExits
        case facilityFireExtinguisher
        case facilityFireDrills
    }
    
    override func encode(to encoder: Encoder) throws
    {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(site, forKey: .site)
        try container.encode(facilityHazardFree, forKey: .facilityHazardFree)
        try container.encode(facilityLighting, forKey: .facilityLighting)
        try container.encode(facilityClean, forKey: .facilityClean)
        try container.encode(facilityVentilation, forKey: .facilityVentilation)
        try container.encode(facilityCofoPosted, forKey: .facilityCofoPosted)
        try container.encode(facilityEmergencyExits, forKey: .facilityEmergencyExits)
        try container.encode(facilityFireExtinguisher, forKey: .facilityFireExtinguisher)
        try container.encode(facilityFireDrills, forKey: .facilityFireDrills)
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        site = try values.decodeIfPresent(Site.self, forKey: .site)
        facilityHazardFree = try values.decode(Int.self, forKey: .facilityHazardFree)
        facilityLighting = try values.decode(Int.self, forKey: .facilityLighting)
        facilityClean = try values.decode(Int.self, forKey: .facilityClean)
        facilityVentilation = try values.decode(Int.self, forKey: .facilityVentilation)
        facilityCofoPosted = try values.decode(Int.self, forKey: .facilityCofoPosted)
        facilityEmergencyExits = try values.decode(Int.self, forKey: .facilityEmergencyExits)
        facilityFireExtinguisher = try values.decode(Int.self, forKey: .facilityFireExtinguisher)
        facilityFireDrills = try values.decode(Int.self, forKey: .facilityFireDrills)
    }

}
