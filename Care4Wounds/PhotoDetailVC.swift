//
//  PhotoDetailVC.swift
//  Care4Wounds
//
//  Created by David Furman on 11/9/15.
//  Copyright © 2015 UCI App Jam Team 5. All rights reserved.
//

import UIKit

class PhotoDetailVC: UIViewController {
    var woundPhoto : WoundPhoto!
    var alertDoctorWhenDone : Bool = false
    
    @IBOutlet weak var painLevelField: UITextField!
    @IBOutlet weak var levelOfConcernSegmentedControl: UISegmentedControl!
    @IBOutlet weak var lengthField: UITextField!
    @IBOutlet weak var photo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photo.image = UIImage(data: woundPhoto.photoImage!)
        
        if (woundPhoto.woundLength?.stringValue != "") {
            lengthField.text = woundPhoto.woundLength?.stringValue
        }
        
        if (woundPhoto.levelOfPain?.stringValue != "") {
            painLevelField.text = woundPhoto.levelOfPain?.stringValue
        }
        
        levelOfConcernSegmentedControl.selectedSegmentIndex = woundPhoto.levelOfConcern!.integerValue
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .ShortStyle
        let dateStr = dateFormatter.stringFromDate(woundPhoto.date!)
        
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: Selector("savePhoto"))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.title = dateStr
    }
    
    func savePhoto() {
        CoreDataHelper.saveData()
        
        if (alertDoctorWhenDone) {
            navigationController?.popToRootViewControllerAnimated(false)
            //navigationController?.pushViewController(viewController: UIViewController, animated: <#T##Bool#>)
        } else {
            // If this is the first photo
            let predicate = NSPredicate(format: "wound == %@", woundPhoto.wound!)
            if (CoreDataHelper.fetchNumberOfEntities("WoundPhoto", predicate: predicate) == 1) {
                navigationController?.popToViewController(self.navigationController?.viewControllers[1] as! WoundTableVC, animated: true)
            } else {
                navigationController?.popToViewController(self.navigationController?.viewControllers[2] as! WoundOptionsVC , animated: true)
            }
        }
    }
    
    @IBAction func painLevelChanged(sender: UITextField) {
        woundPhoto.levelOfPain = NSNumber(float: (sender.text! as NSString).floatValue)
    }
    
    @IBAction func levelOfConcernChanged(sender: UISegmentedControl) {
        woundPhoto.levelOfConcern = sender.selectedSegmentIndex
        
        if (sender.selectedSegmentIndex > 0) {
            let alertController : UIAlertController = UIAlertController(title: "Would you like to alert your doctor when you have finished entering info?", message: nil, preferredStyle: .Alert)
            
            let yesAction = UIAlertAction(title: "Yes", style: .Default) { (_) in
                self.alertDoctorWhenDone = true
            }
            let noAction = UIAlertAction(title: "No", style: .Default) { (_) in
                self.alertDoctorWhenDone = false
            }
            
            alertController.addAction(noAction)
            alertController.addAction(yesAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func symptomsButtonPressed(sender: UIButton) {
        let symptomsVC = SymptomsVC(nibName: "SymptomsVC", bundle: nil)
        symptomsVC.woundPhoto = woundPhoto
        navigationController!.pushViewController(symptomsVC, animated: true)
    }
}
