//
//  Evaluation+CoreDataProperties.swift
//  hawq
//
//  Created by Anthony Shewnarain on 2/27/18.
//  Copyright © 2018 Anthony Shewnarain. All rights reserved.
//
//

import Foundation
import CoreData


extension EvaluationMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EvaluationMO> {
        return NSFetchRequest<EvaluationMO>(entityName: "Evaluation")
    }

    @NSManaged public var id: String?
    @NSManaged public var creationDate: NSDate?
    @NSManaged public var type: String?
    @NSManaged public var status: String?
    @NSManaged public var postingStatus: String?
    @NSManaged public var postingDate: NSDate?
    @NSManaged public var postingConfirmationDate: NSDate?
    @NSManaged public var form: NSData?
    @NSManaged public var evaluator: PersonMO?
    @NSManaged public var reviews: NSSet?

}

// MARK: Generated accessors for reviews
extension EvaluationMO {

    @objc(addReviewsObject:)
    @NSManaged public func addToReviews(_ value: ReviewMO)

    @objc(removeReviewsObject:)
    @NSManaged public func removeFromReviews(_ value: ReviewMO)

    @objc(addReviews:)
    @NSManaged public func addToReviews(_ values: NSSet)

    @objc(removeReviews:)
    @NSManaged public func removeFromReviews(_ values: NSSet)

}
