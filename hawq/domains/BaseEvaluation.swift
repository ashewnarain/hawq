//
//  BaseEvaluation.swift
//  hawq
//
//  Created by Anthony Shewnarain on 2/25/18.
//  Copyright © 2018 Anthony Shewnarain. All rights reserved.
//

import Foundation

class BaseEvaluation: Codable {
    final let id: String
    final let creationDate: Date
    let type: EvaluationType
    var status: EvaluationStatus = .new
    let evaluator: Person
    var reviews: [Review]?
    var postingStatus: EvaluationPostingStatus?
    var postingDate: Date?
    var postingConfirmationDate: Date?
    
    init(type: EvaluationType, evaluator: Person) {
        self.id = UUID().uuidString
        self.creationDate = Date()
        self.type = type
        self.evaluator = evaluator
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case creationDate
        case type
        case status
        case evaluator
        case reviews
        case postingStatus
        case postingDate
        case postingConfirmationDate
    }
    
    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(creationDate, forKey: .creationDate)
        try container.encode(type.rawValue, forKey: .type)
        try container.encode(status.rawValue, forKey: .status)
        try container.encode(evaluator, forKey: .evaluator)
        try container.encodeIfPresent(reviews, forKey: .reviews)
        try container.encodeIfPresent(postingStatus?.rawValue, forKey: .postingStatus)
        try container.encodeIfPresent(postingDate, forKey: .postingDate)
        try container.encodeIfPresent(postingConfirmationDate, forKey: .postingConfirmationDate)
    }
    
    required init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        creationDate = try values.decode(Date.self, forKey: .creationDate)
        type = EvaluationType(rawValue: try values.decode(String.self, forKey: .type))!
        status = EvaluationStatus(rawValue: try values.decode(String.self, forKey: .status))!
        evaluator = try values.decode(Person.self, forKey: .evaluator)
        reviews = try values.decodeIfPresent([Review].self, forKey: .reviews)
        if let _postingStatus = try values.decodeIfPresent(String.self, forKey: .postingStatus) {
                postingStatus = EvaluationPostingStatus(rawValue: _postingStatus)
        }
        postingDate = try values.decodeIfPresent(Date.self, forKey: .postingDate)
        postingConfirmationDate = try values.decodeIfPresent(Date.self, forKey: .postingConfirmationDate)
    }
}
