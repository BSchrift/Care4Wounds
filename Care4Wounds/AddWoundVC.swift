//
//  AddWoundVC.swift
//  Care4Wounds
//
//  Created by David Furman on 11/9/15.
//  Copyright © 2015 UCI App Jam Team 5. All rights reserved.
//

import UIKit

class AddWoundVC : UIViewController {
    @IBOutlet weak var bodyLocationField: UITextField!
    
    @IBAction func addWoundPressed(sender: UIButton) {
        if (bodyLocationField.text != "") {
            // Inserts and returns a new Wound
            let wound : Wound = CoreDataHelper.insertManagedObject("Wound") as! Wound
            wound.bodyLocation = bodyLocationField.text
            CoreDataHelper.saveData()
            navigationController?.popViewControllerAnimated(true)
        }
    }
}
