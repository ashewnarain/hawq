//
//  SignatureVC.swift
//  hawq
//
//  Created by Anthony Shewnarain on 2/19/18.
//  Copyright © 2018 Anthony Shewnarain. All rights reserved.
//

import UIKit

class SignatureVC: UIViewController {

    var onReturn:((_ result: Data) -> ())?
    private var path = UIBezierPath()
    private var startPoint = CGPoint()
    var signatureData: Data?
    
    @IBOutlet weak var canvasView: UIView!
    
    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        let image = renderer.image { ctx in
            //view.drawHierarchy(in: view.subviews[0].bounds, afterScreenUpdates: true)
            canvasView.drawHierarchy(in: canvasView.bounds, afterScreenUpdates: true)
        }
        self.signatureData = UIImagePNGRepresentation(image)
        //self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: {
            if let data = self.signatureData {
                self.onReturn!(data)
            }
        })
        //onReturn?(signatureData!.base64EncodedString())
    }
    
    @IBAction func clearTapped(_ sender: Any) {
        path.removeAllPoints()
        //canvasView.layer.sublayers = nil
        canvasView.layer.sublayers?.forEach({ (layer) in
            if let thisLayer = layer as? CAShapeLayer {
                thisLayer.removeFromSuperlayer()
            }
        })
        canvasView.setNeedsDisplay()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let point = touch?.location(in: canvasView) {
            startPoint = point
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let point = touch?.location(in: canvasView) {
            path.move(to: startPoint)
            path.addLine(to: point)
            startPoint = point
            
            draw()
        }
    }
    
    func draw() {
        let strokeLayer = CAShapeLayer()
        strokeLayer.fillColor = nil
        strokeLayer.lineWidth = 2
        strokeLayer.strokeColor = UIColor.black.cgColor
        strokeLayer.path = path.cgPath
        canvasView.layer.addSublayer(strokeLayer)
        
        canvasView.setNeedsDisplay()
        path.removeAllPoints()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        AppDelegate.AppUtility.lockOrientation(.landscape, andRotateTo: .landscapeLeft)
        //AppDelegate.AppUtility.lockOrientation(.landscape)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppDelegate.AppUtility.lockOrientation(.all, andRotateTo: .portrait)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
