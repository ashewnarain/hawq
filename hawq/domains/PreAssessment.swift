//
//  PreAssessment.swift
//  hawq
//
//  Created by Anthony Shewnarain on 2/25/18.
//  Copyright © 2018 Anthony Shewnarain. All rights reserved.
//

import Foundation

class PreAssessment: BaseEvaluation {
    var site: Site
    var facility: Facility
    var signature: Media?
    
    init(evaluator: Person) {
        site = Site()
        facility = Facility()
        super.init(type: .PreAssessment, evaluator: evaluator)
        
    }
    
    private enum CodingKeys: String, CodingKey {
        case site
        case facility
    }
    
    override func encode(to encoder: Encoder) throws
    {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(site, forKey: .site)
        try container.encode(facility, forKey: .facility)
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        site = try values.decode(Site.self, forKey: .site)
        facility = try values.decode(Facility.self, forKey: .facility)
        try super.init(from: decoder)
    }

}
