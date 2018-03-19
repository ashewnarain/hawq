//
//  EvaluationType.swift
//  hawq
//
//  Created by Anthony Shewnarain on 2/27/18.
//  Copyright © 2018 Anthony Shewnarain. All rights reserved.
//

import Foundation

enum EvaluationType: String {
    case PreAssessment="PreAssessment"
}

enum EvaluationPostingStatus: String {
    case pending="pending", sent="sent"
}

enum EvaluationStatus: String {
    case new, draft, complete
}

enum MediaType: String {
    case signature, photo, video
}
