//
//  MostRecentVC.swift
//  hawq
//
//  Created by Anthony Shewnarain on 3/5/18.
//  Copyright © 2018 Anthony Shewnarain. All rights reserved.
//

import UIKit
import CoreData

class MostRecentVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tvEvaluations: UITableView!
    var evaluationMOList = [PreAssessment]()
    
    override func viewWillAppear(_ animated: Bool) {
        print("MostRecentVC - viewWillAppear()")
        super.viewWillAppear(animated)
        
        evaluationMOList = CoreDataUtility.getEvaluationList()
    
        tvEvaluations.reloadData()
    }
    
    override func viewDidLoad() {
        print("MostRecentVC - viewDidLoad()")
        super.viewDidLoad()
        
        tvEvaluations.delegate = self
        tvEvaluations.dataSource = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return evaluationMOList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvEvaluations.dequeueReusableCell(withIdentifier: "normalCell", for: indexPath)

        let preAssessment = evaluationMOList[indexPath.row]
   
        if((preAssessment.site.name ?? "").isEmpty) {
            cell.textLabel?.text = "Site Name Not Provided"
        } else {
            cell.textLabel?.text = "\(preAssessment.site.name!)"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .medium
        cell.detailTextLabel?.text = dateFormatter.string(for: preAssessment.creationDate)
        cell.detailTextLabel?.textColor = UIColor.lightGray

    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //let evaluationTVC = EvaluationTVC()
        //evaluationTVC.selectedEvaluationID = evaluationMOList[indexPath.row].id
        //self.navigationController?.pushViewController(evaluationTVC, animated: true)
        print("didSelectRowAt id=\(evaluationMOList[indexPath.row].id)")
        //self.performSegue(withIdentifier: "showEvaluation", sender: nil)
        let evaluationTVC = storyboard?.instantiateViewController(withIdentifier: "EvaluationTVC") as! EvaluationTVC
        evaluationTVC.preAssessment = evaluationMOList[indexPath.row]
        self.navigationController?.pushViewController(evaluationTVC, animated: true)
        

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
