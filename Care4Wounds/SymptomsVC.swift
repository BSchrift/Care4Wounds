//
//  SymptomsVC.swift
//  Care4Wounds
//
//  Created by David Furman on 11/11/15.
//  Copyright © 2015 UCI App Jam Team 5. All rights reserved.
//

import UIKit

class SymptomsVC: UIViewController {
    var woundPhoto : WoundPhoto!
    @IBOutlet weak var symptomsLabel: UILabel!
    
    @IBOutlet weak var pusSwitch: UISwitch!
    @IBOutlet weak var odorSwitch: UISwitch!
    @IBOutlet weak var feverSwitch: UISwitch!
    @IBOutlet weak var rednessSwitch: UISwitch!
    @IBOutlet weak var warmthSwitch: UISwitch!
    @IBOutlet weak var swellingSwitch: UISwitch!
    @IBOutlet weak var painSwitch: UISwitch!
    @IBOutlet weak var fluidSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Symptoms"
        
        let parentVC = navigationController!.viewControllers[navigationController!.viewControllers.endIndex-2]
        if (parentVC.isKindOfClass(PhotoDetailVC)) {
            symptomsLabel.text = "Select the symptoms you have:"
            let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: Selector("retainChanges"))
            navigationItem.rightBarButtonItem = rightBarButtonItem
        } else {
            symptomsLabel.text = "These are your most recent symptoms:"
            toggleSwitches(false)
        }
        loadSymptoms()
    }
    
    func toggleSwitches(enabled : Bool) {
        pusSwitch.enabled      = enabled
        odorSwitch.enabled     = enabled
        feverSwitch.enabled    = enabled
        rednessSwitch.enabled  = enabled
        warmthSwitch.enabled   = enabled
        swellingSwitch.enabled = enabled
        painSwitch.enabled     = enabled
        fluidSwitch.enabled    = enabled
    }
    
    func retainChanges() {
        updateSymptoms()
        navigationController?.popViewControllerAnimated(true)
    }
    
    func loadSymptoms() {
        pusSwitch.on      = (woundPhoto.hasPus?.boolValue != nil)           ? (woundPhoto.hasPus?.boolValue)!           : false
        odorSwitch.on     = (woundPhoto.hasBadOdor?.boolValue != nil)       ? (woundPhoto.hasBadOdor?.boolValue)!       : false
        feverSwitch.on    = (woundPhoto.hasFever?.boolValue != nil)         ? (woundPhoto.hasFever?.boolValue)!         : false
        rednessSwitch.on  = (woundPhoto.hasRedness?.boolValue != nil)       ? (woundPhoto.hasRedness?.boolValue)!       : false
        warmthSwitch.on   = (woundPhoto.hasWarmth?.boolValue != nil)        ? (woundPhoto.hasWarmth?.boolValue)!        : false
        swellingSwitch.on = (woundPhoto.hasSwelling?.boolValue != nil)      ? (woundPhoto.hasSwelling?.boolValue)!      : false
        painSwitch.on     = (woundPhoto.hasPain?.boolValue != nil)          ? (woundPhoto.hasPain?.boolValue)!          : false
        fluidSwitch.on    = (woundPhoto.hasFluidDrainage?.boolValue != nil) ? (woundPhoto.hasFluidDrainage?.boolValue)! : false

        
    }
    
    func updateSymptoms() {
        woundPhoto.hasPus = pusSwitch.on
        woundPhoto.hasBadOdor = odorSwitch.on
        woundPhoto.hasFever = feverSwitch.on
        woundPhoto.hasRedness = rednessSwitch.on
        woundPhoto.hasWarmth = warmthSwitch.on
        woundPhoto.hasSwelling = swellingSwitch.on
        woundPhoto.hasPain = painSwitch.on
        woundPhoto.hasFluidDrainage = fluidSwitch.on
    }
    
}
