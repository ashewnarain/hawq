//
//  Review.swift
//  hawq
//
//  Created by Anthony Shewnarain on 2/25/18.
//  Copyright © 2018 Anthony Shewnarain. All rights reserved.
//

import Foundation

class Review: Codable {
    let id: String
    let date: Date
    let status: String
    var comment: String?
    var reviewer: Person
    
    enum ReviewStatus {
        case new, needsRevisit, immediateAttentionRequired, notApproved, approved
    }
    
    init(id: String, date: Date, status: String, comment: String?, reviewer: Person) {
        self.id = id
        self.date = date
        self.status = status
        self.comment = comment
        self.reviewer = reviewer
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case date
        case status
        case comment
        case reviewer
    }
    
    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(date, forKey: .date)
        try container.encode(status, forKey: .status)
        try container.encodeIfPresent(comment, forKey: .comment)
        try container.encode(reviewer, forKey: .reviewer)
    }
    
    required init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        date = try values.decode(Date.self, forKey: .date)
        status = try values.decode(String.self, forKey: .status)
        comment = try values.decode(String.self, forKey: .comment)
        reviewer = try values.decode(Person.self, forKey: .reviewer)
    }
    
}
