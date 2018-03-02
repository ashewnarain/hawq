//
//  Person+CoreDataProperties.swift
//  hawq
//
//  Created by Anthony Shewnarain on 2/27/18.
//  Copyright © 2018 Anthony Shewnarain. All rights reserved.
//
//

import Foundation
import CoreData


extension PersonMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonMO> {
        return NSFetchRequest<PersonMO>(entityName: "Person")
    }

    @NSManaged public var id: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var email: String?
    @NSManaged public var evaluations: EvaluationMO?
    @NSManaged public var reviews: NSSet?

}

// MARK: Generated accessors for reviews
extension PersonMO {

    @objc(addReviewsObject:)
    @NSManaged public func addToReviews(_ value: ReviewMO)

    @objc(removeReviewsObject:)
    @NSManaged public func removeFromReviews(_ value: ReviewMO)

    @objc(addReviews:)
    @NSManaged public func addToReviews(_ values: NSSet)

    @objc(removeReviews:)
    @NSManaged public func removeFromReviews(_ values: NSSet)

}
