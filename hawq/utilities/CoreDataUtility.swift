//
//  CoreDataUtility.swift
//  hawq
//
//  Created by Anthony Shewnarain on 3/7/18.
//  Copyright © 2018 Anthony Shewnarain. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataUtility {
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    public static func saveEvaluation(preAssessment: PreAssessment) {
        let context = appDelegate.persistentContainer.viewContext
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Evaluation")
        request.predicate = NSPredicate(format: "id == %@", preAssessment.id)
        
        var evaluationMO: EvaluationMO?
        do {
            if let evaluationMOList = try context.fetch(request) as? [EvaluationMO] {
                evaluationMO = evaluationMOList.last
            }
        } catch {
            print("Failed to fetch evaluation: \(error)")
        }

        if nil == evaluationMO {
            print("Saving NEW Evaluation - id=\(preAssessment.id)")
            evaluationMO = EvaluationMO(context: context)
        } else {
            print("Updating existing Evaluation - id=\(preAssessment.id)")
        }
        evaluationMO!.id = preAssessment.id
        evaluationMO!.creationDate = preAssessment.creationDate
        evaluationMO!.form = try? JSONEncoder().encode(preAssessment)
        evaluationMO!.status = preAssessment.status.rawValue
        evaluationMO!.type = preAssessment.type.rawValue

        // save evaluator
        let personMO = PersonMO(context: context)
        personMO.id = preAssessment.id
        personMO.firstName = preAssessment.evaluator.firstName
        personMO.lastName = preAssessment.evaluator.lastName
        personMO.email = preAssessment.evaluator.email
        personMO.phone = preAssessment.evaluator.phone
        evaluationMO!.evaluator = personMO
        
        // save signature
        if let signature = preAssessment.signature {
            let mediaMO = MediaMO(context: context)
            mediaMO.mediaID = signature.mediaID
            mediaMO.creationDate = signature.creationDate
            mediaMO.mediaData = signature.mediaData
            mediaMO.mediaDescription = signature.mediaDescription
            mediaMO.mediaName = signature.mediaName
            mediaMO.mediaType = signature.mediaType.rawValue
            evaluationMO!.addToMedia(mediaMO)
        }
        
        if let photos = preAssessment.photos {
            for photo in photos {
                let mediaMO = MediaMO(context: context)
                mediaMO.mediaID = photo.mediaID
                mediaMO.creationDate = photo.creationDate
                mediaMO.mediaData = photo.mediaData
                mediaMO.mediaDescription = photo.mediaDescription
                mediaMO.mediaName = photo.mediaName
                mediaMO.mediaType = photo.mediaType.rawValue
                evaluationMO!.addToMedia(mediaMO)
            }
        }
        
        do {
            try context.save()
        } catch {
            print("Failed saving evaluation - error=\(error)")
        }
    }
    
    public static func getEvaluation(evaluationId: String) -> PreAssessment? {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Evaluation")
        request.predicate = NSPredicate(format: "id = %@", "\(evaluationId)")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let formData = data.value(forKey: "form") as! Data
                let preAssessment = try JSONDecoder().decode(PreAssessment.self, from: formData)
                return preAssessment
            }
        } catch {
            print("Failed to fetch data - error=\(error)")
        }
        return nil
    }
    
    public static func getEvaluationMedia(evaluationId: String) -> [Media] {
        var mediaMOList = [Media]()
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Media")
        request.predicate = NSPredicate(format: "evaluation.id = %@", "\(evaluationId)")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request) as! [MediaMO]
            for mediaMO in result {
                print("Found signature in db...")
                let media = Media(mediaID: mediaMO.mediaID!, mediaData: mediaMO.mediaData!, mediaType: MediaType(rawValue: mediaMO.mediaType!)!)
                media.creationDate = mediaMO.creationDate!
                media.mediaDescription = mediaMO.mediaDescription
                media.mediaName = mediaMO.mediaName
                mediaMOList.append(media)
            }
        } catch {
            print("Failed to fetch data - error=\(error)")
        }
        return mediaMOList
    }
    
    public static func getEvaluationList() -> [PreAssessment] {
        var preAssessmentList = [PreAssessment]()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Evaluation")
        request.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            
            for data in result as! [NSManagedObject] {
                let formData = data.value(forKey: "form") as! Data
                let preAssessment = try JSONDecoder().decode(PreAssessment.self, from: formData)
                preAssessmentList.append(preAssessment)
            }
        } catch {
            print("Failed to fetch data - error=\(error)")
        }
        return preAssessmentList
    }
}
