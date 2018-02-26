//
//  EvaluationTVC.swift
//  hawq
//
//  Created by Anthony Shewnarain on 2/16/18.
//  Copyright © 2018 Anthony Shewnarain. All rights reserved.
//

import UIKit

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
    
    var imagePhotos = [UIImage]()
    
    @IBAction func btnNavigationDone(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCameraAction(_ sender: Any) {
        self.loadImagePickerController()
    }
    
    override func viewDidLoad() {
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
    }
    
    @objc func imgViewSignatureTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        //let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        // Your action
        //self.navigationController?.pushViewController(signatureVC, animated: true)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let signatureVC = storyBoard.instantiateViewController(withIdentifier: "signatureVC") as! SignatureVC
        self.present(signatureVC, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 5
//    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 3
//    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        switch section {
//        case 0:
//            return "Supervisor Review"
//        case 1:
//            return "Evaluation"
//        case 2:
//            return "Photos"
//        case 3:
//            return "Survey"
//        case 4:
//            return "Signature"
//        default:
//            return nil
//        }
//        }

    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//
//        // Configure the cell...
//        cell.textLabel?.text = "This is row number \(indexPath.row)"
//
//        return cell
//    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
