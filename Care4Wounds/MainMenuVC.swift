//
//  MainMenuVC.swift
//  Care4Wounds
//
//  Created by David Furman on 11/8/15.
//  Copyright © 2015 UCI App Jam Team 5. All rights reserved.
//

import UIKit

class MainMenuVC: UIViewController {
    
    @IBAction func doctorManagementPressed(sender: UIButton) {
      let selectWoundVC = SelectWoundVC(nibName: "SelectWoundVC", bundle: nil)
      navigationController!.pushViewController(selectWoundVC, animated: true)
        
    }
    @IBAction func woundManagementPressed(sender: UIButton) {
        let woundTableVC = WoundTableVC(nibName: "WoundTableVC", bundle: nil)
        navigationController!.pushViewController(woundTableVC, animated: true)
    }
}

