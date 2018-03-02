//
//  Review+CoreDataProperties.swift
//  hawq
//
//  Created by Anthony Shewnarain on 2/27/18.
//  Copyright © 2018 Anthony Shewnarain. All rights reserved.
//
//

import Foundation
import CoreData


extension ReviewMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ReviewMO> {
        return NSFetchRequest<ReviewMO>(entityName: "Review")
    }

    @NSManaged public var id: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var status: String?
    @NSManaged public var comment: String?
    @NSManaged public var reviewer: PersonMO?
    @NSManaged public var evaluation: EvaluationMO?

}
