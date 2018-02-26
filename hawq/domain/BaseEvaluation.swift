//
//  BaseEvaluation.swift
//  hawq
//
//  Created by Anthony Shewnarain on 2/25/18.
//  Copyright © 2018 Anthony Shewnarain. All rights reserved.
//

import Foundation

class BaseEvaluation {
    private final var id = UUID().uuidString
    private final var creationDate = NSDate()
    private var type: String
    private var status: EvaluationStatus = .new
    private var evaluator: Person
    private var reviews: [Review]?
    private var postingStatus: EvaluationPostingStatus?
    private var postingDate: NSDate?
    private var postingConfirmationDate: NSDate?
    
    enum EvaluationStatus {
        case new, draft, complete
    }
    
    enum EvaluationPostingStatus {
        case pending, sent
    }
    
    init(type: String, evaluator: Person) {
        self.type = type
        self.evaluator = evaluator
    }
    
}
