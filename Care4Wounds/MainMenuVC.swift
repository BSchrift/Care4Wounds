//
//  MainMenuVC.swift
//  Care4Wounds
//
//  Created by David Furman on 11/8/15.
//  Copyright © 2015 UCI App Jam Team 5. All rights reserved.
//

import UIKit

class MainMenuVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func doctorManagementPressed(sender: UIButton) {
        
    }
    @IBAction func woundManagementPressed(sender: UIButton) {
        let woundTableVC = WoundTableVC(nibName: "WoundTableVC", bundle: nil)
        navigationController!.pushViewController(woundTableVC, animated: true)
    }
}

