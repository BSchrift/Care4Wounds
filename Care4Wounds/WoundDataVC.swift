//
//  WoundDataVC.swift
//  Care4Wounds
//
//  Created by David Furman on 11/9/15.
//  Copyright © 2015 UCI App Jam Team 5. All rights reserved.
//

import UIKit
import MessageUI

class WoundDataVC: UIViewController, MFMailComposeViewControllerDelegate {
    var wound : Wound!
    
    @IBOutlet weak var firstPicture: UIImageView!
    @IBOutlet weak var currentPicture: UIImageView!
    @IBOutlet weak var firstDateLabel: UILabel!
    @IBOutlet weak var currentDateLabel: UILabel!
    @IBOutlet weak var firstLengthLabel: UILabel!
    @IBOutlet weak var currentLengthLabel: UILabel!
    @IBOutlet weak var firstConcernLabel: UILabel!
    @IBOutlet weak var currentConcernLabel: UILabel!
    @IBOutlet weak var firstSymptomsTextView: UITextView!
    @IBOutlet weak var currentSymptomsTextView: UITextView!
    
    var firstWoundPhoto : WoundPhoto?
    var currentWoundPhoto : WoundPhoto?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Wound Data"
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Compose, target: self, action: Selector("presentMailVC"))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        loadPhotos()
        loadDates()
        loadLengths()
        loadConcern()
        loadSymptoms()
    }
    
    func loadPhotos() {
        firstWoundPhoto = Wound.getPhotoBasedOnTime(wound, basedOnRecency: true)
        currentWoundPhoto = Wound.getPhotoBasedOnTime(wound, basedOnRecency: false)
        
        firstPicture.image = UIImage(data: (firstWoundPhoto!.photoImage!))
        currentPicture.image = UIImage(data: (currentWoundPhoto!.photoImage!))
    }
    
    func loadDates() {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .ShortStyle
        firstDateLabel.text = dateFormatter.stringFromDate(firstWoundPhoto!.date!)
        currentDateLabel.text = dateFormatter.stringFromDate(currentWoundPhoto!.date!)
    }
    
    func loadLengths() {
        firstLengthLabel.text = (firstWoundPhoto?.woundLength!.stringValue)! + "\""
        currentLengthLabel.text = (currentWoundPhoto?.woundLength!.stringValue)! + "\""
    }
    
    func loadConcern() {
        switch (firstWoundPhoto!.levelOfConcern!.integerValue) {
        case 0:
            firstConcernLabel.text = "Concern: None"
        case 1:
            firstConcernLabel.text = "Concern: A Little"
        case 2:
            firstConcernLabel.text = "Concern: A Lot"
        default:
            firstConcernLabel.text = "Concern: None"
        }
        switch (currentWoundPhoto!.levelOfConcern!.integerValue) {
        case 0:
            currentConcernLabel.text = "Concern: None"
        case 1:
            currentConcernLabel.text = "Concern: A Little"
        case 2:
            currentConcernLabel.text = "Concern: A Lot"
        default:
            currentConcernLabel.text = "Concern: None"
        }
    }
    
    func loadSymptoms() {
        var firstSymptoms : String = ""
        if (firstWoundPhoto!.hasPus?.boolValue != nil) && (firstWoundPhoto!.hasPus?.boolValue)! {
            firstSymptoms += "Pus - "
        }
        if (firstWoundPhoto!.hasBadOdor?.boolValue != nil) && (firstWoundPhoto!.hasBadOdor?.boolValue)! {
            firstSymptoms += "Bad Odor - "
        }
        if (firstWoundPhoto!.hasFever?.boolValue != nil) && (firstWoundPhoto!.hasFever?.boolValue)! {
            firstSymptoms += "Fever - "
        }
        if (firstWoundPhoto!.hasRedness?.boolValue != nil) && (firstWoundPhoto!.hasRedness?.boolValue)! {
            firstSymptoms += "Redness - "
        }
        if (firstWoundPhoto!.hasWarmth?.boolValue != nil) && (firstWoundPhoto!.hasWarmth?.boolValue)! {
            firstSymptoms += "Warmth - "
        }
        if (firstWoundPhoto!.hasSwelling?.boolValue != nil) && (firstWoundPhoto!.hasSwelling?.boolValue)! {
            firstSymptoms += "Swelling - "
        }
        if (firstWoundPhoto!.hasPain?.boolValue != nil) && (firstWoundPhoto!.hasPain?.boolValue)! {
            firstSymptoms += "Pain - "
        }
        if (firstWoundPhoto!.hasFluidDrainage?.boolValue != nil) && (firstWoundPhoto!.hasFluidDrainage?.boolValue)! {
            firstSymptoms += "Fluid Drainage - "
        }
        if (firstSymptoms.characters.count > 0) {
            firstSymptoms = firstSymptoms.substringToIndex(firstSymptoms.endIndex.predecessor().predecessor().predecessor())
        }
        firstSymptomsTextView.text! += "\n" + firstSymptoms
        
        var currentSymptoms : String = ""
        if (currentWoundPhoto!.hasPus?.boolValue != nil) && (currentWoundPhoto!.hasPus?.boolValue)! {
            currentSymptoms += "Pus - "
        }
        if (currentWoundPhoto!.hasBadOdor?.boolValue != nil) && (currentWoundPhoto!.hasBadOdor?.boolValue)! {
            currentSymptoms += "Bad Odor - "
        }
        if (currentWoundPhoto!.hasFever?.boolValue != nil) && (currentWoundPhoto!.hasFever?.boolValue)! {
            currentSymptoms += "Fever - "
        }
        if (currentWoundPhoto!.hasRedness?.boolValue != nil) && (currentWoundPhoto!.hasRedness?.boolValue)! {
            currentSymptoms += "Redness - "
        }
        if (currentWoundPhoto!.hasWarmth?.boolValue != nil) && (currentWoundPhoto!.hasWarmth?.boolValue)! {
            currentSymptoms += "Warmth - "
        }
        if (currentWoundPhoto!.hasSwelling?.boolValue != nil) && (currentWoundPhoto!.hasSwelling?.boolValue)! {
            currentSymptoms += "Swelling - "
        }
        if (currentWoundPhoto!.hasPain?.boolValue != nil) && (currentWoundPhoto!.hasPain?.boolValue)! {
            currentSymptoms += "Pain - "
        }
        if (currentWoundPhoto!.hasFluidDrainage?.boolValue != nil) && (currentWoundPhoto!.hasFluidDrainage?.boolValue)! {
            currentSymptoms += "Fluid Drainage - "
        }
        if (currentSymptoms.characters.count > 0) {
            currentSymptoms = currentSymptoms.substringToIndex(currentSymptoms.endIndex.predecessor().predecessor().predecessor())
        }
        currentSymptomsTextView.text! += "\n" + currentSymptoms
        
        firstSymptomsTextView.font = UIFont(name: "Helvetica Neue", size: 17)
        currentSymptomsTextView.font = UIFont(name: "Helvetica Neue", size: 17)
        firstSymptomsTextView.editable = false
        currentSymptomsTextView.editable = false
    }

    @IBAction func presentMailVC() {
        if (MFMailComposeViewController.canSendMail()) {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = .ShortStyle
            dateFormatter.timeStyle = .ShortStyle
            let fileName = wound.bodyLocation! + " " + dateFormatter.stringFromDate(NSDate())
            
            let pdfData = NSMutableData()
            UIGraphicsBeginPDFContextToData(pdfData, view.bounds, nil)
            UIGraphicsBeginPDFPage()
            
            let pdfContext = UIGraphicsGetCurrentContext()
            view.layer.renderInContext(pdfContext!)
            UIGraphicsEndPDFContext()
            
            let docDirectories = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            let docDirectory = docDirectories.first
            let docDirectoryFileName = docDirectory?.stringByAppendingString(fileName)
            
            pdfData.writeToFile(docDirectoryFileName!, atomically: true)
        
            let dateStr = dateFormatter.stringFromDate(NSDate())
            
            var username = UIDevice.currentDevice().name
            username = username.stringByReplacingOccurrencesOfString("'s iPhone", withString: "")
            username = username.stringByReplacingOccurrencesOfString("'s iPad", withString: "")
            
            let picker = MFMailComposeViewController()
            picker.mailComposeDelegate = self
            picker.setSubject("Care4Wounds Update")
            picker.setMessageBody("Care4Wounds Update: " + dateStr + "\nFrom " + username, isHTML: true)
            picker.addAttachmentData(pdfData, mimeType: "application/pdf", fileName: "Wound")
            
            presentViewController(picker, animated: true, completion: nil)
        } else {
            let alertController : UIAlertController = UIAlertController(title: "Please add an account in the Mail app before attempting to send an email.", message: nil, preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}


