//
//  EvaluationTVC.swift
//  hawq
//
//  Created by Anthony Shewnarain on 2/16/18.
//  Copyright © 2018 Anthony Shewnarain. All rights reserved.
//

import UIKit
import CoreData

class EvaluationTVC: UITableViewController {

    // Review
    @IBOutlet weak var lblReviewDate: UILabel!
    @IBOutlet weak var lblReviewer: UILabel!
    @IBOutlet weak var lblReviewStatus: UILabel!
    @IBOutlet weak var lblReviewFollowUp: UILabel!
    @IBOutlet weak var textViewReview: UITextView!
    // Photos
    @IBOutlet weak var collectionViewPhotos: UICollectionView!
    // Site
    @IBOutlet weak var txtSiteName: UITextField!
    @IBOutlet weak var txtSiteCategory: UITextField!
    @IBOutlet weak var txtSiteAddressLine1: UITextField!
    @IBOutlet weak var txtSiteAddressLine2: UITextField!
    @IBOutlet weak var txtSiteCity: UITextField!
    @IBOutlet weak var txtSiteState: UITextField!
    @IBOutlet weak var txtSiteZipCode: UITextField!
    @IBOutlet weak var txtSiteTelephone: UITextField!
    @IBOutlet weak var txtSiteRepresentative: UITextField!
    // Survey
    @IBOutlet weak var segFacilityHazardFree: UISegmentedControl!
    @IBOutlet weak var segFacilityLighting: UISegmentedControl!
    @IBOutlet weak var segFacilityClean: UISegmentedControl!
    @IBOutlet weak var segFacilityVentilation: UISegmentedControl!
    @IBOutlet weak var segFacilityCofoPosted: UISegmentedControl!
    @IBOutlet weak var segFacilityEmergencyExits: UISegmentedControl!
    @IBOutlet weak var segFacilityFireExtinguisher: UISegmentedControl!
    @IBOutlet weak var segFacilityFireDrills: UISegmentedControl!
    // Signature
    @IBOutlet weak var imgViewSignature: UIImageView!
    
    var photoList = [Media]()
    var preAssessment: PreAssessment?
        
    override func viewDidLoad() {
        print("EvaluationTVC - viewDidLoad()")
        super.viewDidLoad()
        collectionViewPhotos.delegate = self
        collectionViewPhotos.dataSource = self
        
        lblReviewDate.text? = "\(NSDate())"
        lblReviewer.text? = "Anthony Shewnarain"
        lblReviewStatus.text? = "APPROVED"
        lblReviewFollowUp.text? = "NOT REQUIRED"
        textViewReview.text? = "The evaluation was very detailed and thorough. The photos taken were appropriate to visualize the safety parameters. While the form is still a work in progress we will approve this location for the time being."
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imgViewSignatureTapped(tapGestureRecognizer:)))
        imgViewSignature.addGestureRecognizer(tapGestureRecognizer)
        
        if nil != preAssessment {
            importEvaluation(evaluation: preAssessment!)
        } else {
            preAssessment = createEvaluation()
        }
    }
    
    @IBAction func btnDoneTapped(_ sender: Any) {
        preAssessment = refreshEvaluation(evaluation: preAssessment!)
        CoreDataUtility.saveEvaluation(preAssessment: preAssessment!)
        self.navigationController?.popViewController(animated: true)
    }
    
    func createEvaluation()-> PreAssessment {
        //TODO: load evaluator details here
        let evaluator = Person(id: "ashewna", firstName: "Anthony", lastName: "Shewnarain", email: "anthony.shewnarain@gmail.com", phone: "917-805-0636")
        let preAssessment =  PreAssessment(evaluator: evaluator)
        print("Created NEW Evaluation - id=\(preAssessment.id)")
        return preAssessment
    }
    
    
    @IBAction func btnCameraAction(_ sender: Any) {
        self.loadImagePickerController()
    }
    
    @objc func imgViewSignatureTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let signatureVC = storyBoard.instantiateViewController(withIdentifier: "signatureVC") as! SignatureVC
        self.navigationController?.present(signatureVC, animated: true) {
            signatureVC.onReturn = { result in
                if nil != self.preAssessment!.signature {
                    print("Updating existing signature...")
                    self.preAssessment!.signature!.creationDate = Date()
                    self.preAssessment!.signature!.mediaData = result
                } else {
                    print("Created NEW signature...")
                    self.preAssessment!.signature = Media(mediaID: UUID().uuidString, mediaData: result, mediaType: MediaType.signature)
                }
                
                self.imgViewSignature.image = UIImage(data: result)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func refreshEvaluation(evaluation: PreAssessment)->PreAssessment {
        evaluation.site.address.line1 = txtSiteAddressLine1.text
        evaluation.site.address.line2 = txtSiteAddressLine2.text
        evaluation.site.address.city = txtSiteCity.text
        evaluation.site.address.state = txtSiteState.text
        evaluation.site.address.zipCode = txtSiteZipCode.text
        
        evaluation.site.name = txtSiteName.text
        evaluation.site.category = txtSiteCategory.text
        evaluation.site.primaryNumber = txtSiteTelephone.text
        evaluation.site.representative = txtSiteRepresentative.text
        
        evaluation.facility.isHazardFree = segFacilityHazardFree.selectedSegmentIndex
        evaluation.facility.isLighting = segFacilityLighting.selectedSegmentIndex
        evaluation.facility.isClean = segFacilityClean.selectedSegmentIndex
        evaluation.facility.isVentilation = segFacilityVentilation.selectedSegmentIndex
        evaluation.facility.isCofoPosted = segFacilityCofoPosted.selectedSegmentIndex
        evaluation.facility.isEmergencyExits = segFacilityEmergencyExits.selectedSegmentIndex
        evaluation.facility.isFireExtinguisher = segFacilityFireExtinguisher.selectedSegmentIndex
        evaluation.facility.isFireDrills = segFacilityFireDrills.selectedSegmentIndex
        
        //photos
        evaluation.photos = photoList
        
        return evaluation
    }
    
    func importEvaluation(evaluation: PreAssessment) {
        print("Loading evaluation - evaluationID=\(evaluation.id)")
        txtSiteAddressLine1.text = evaluation.site.address.line1
        txtSiteAddressLine2.text = evaluation.site.address.line2
        txtSiteCity.text = evaluation.site.address.city
        txtSiteState.text = evaluation.site.address.state
        txtSiteZipCode.text = evaluation.site.address.zipCode
        txtSiteName.text = evaluation.site.name
        txtSiteCategory.text = evaluation.site.category
        txtSiteTelephone.text = evaluation.site.primaryNumber
        txtSiteRepresentative.text = evaluation.site.representative
        
        segFacilityHazardFree.selectedSegmentIndex = evaluation.facility.isHazardFree
        segFacilityLighting.selectedSegmentIndex = evaluation.facility.isLighting
        segFacilityClean.selectedSegmentIndex = evaluation.facility.isClean
        segFacilityVentilation.selectedSegmentIndex = evaluation.facility.isVentilation
        segFacilityCofoPosted.selectedSegmentIndex = evaluation.facility.isCofoPosted
        segFacilityEmergencyExits.selectedSegmentIndex = evaluation.facility.isEmergencyExits
        segFacilityFireExtinguisher.selectedSegmentIndex = evaluation.facility.isFireExtinguisher
        segFacilityFireDrills.selectedSegmentIndex = evaluation.facility.isFireDrills
        
        //TODO: fetch photos and signature data - async?
        let mediaList = CoreDataUtility.getEvaluationMedia(evaluationId: evaluation.id)
        for media in mediaList {
            if media.mediaType == MediaType.signature {
                preAssessment!.signature = media
                imgViewSignature.image = UIImage(data: media.mediaData)
            } else {
                photoList.append(media)
            }
        }
    }

}
