//
//  Review.swift
//  hawq
//
//  Created by Anthony Shewnarain on 2/25/18.
//  Copyright © 2018 Anthony Shewnarain. All rights reserved.
//

import Foundation

class Review {
    private var id: String
    private var date: NSDate
    private var status: String
    private var comment: String?
    private var reviewer: Person
    
    enum ReviewStatus {
        case new, needsRevisit, immediateAttentionRequired, notApproved, approved
    }
    
    init(id: String, date: NSDate, status: String, comment: String?, reviewer: Person) {
        self.id = id
        self.date = date
        self.status = status
        self.comment = comment
        self.reviewer = reviewer
    }
    
}
