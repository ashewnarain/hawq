//
//  ViewController.swift
//  hawq
//
//  Created by Anthony Shewnarain on 2/16/18.
//  Copyright © 2018 Anthony Shewnarain. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstNavigationItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        firstNavigationItem.title = "Welcome!"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

