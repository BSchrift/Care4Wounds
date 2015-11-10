//
//  PhotoAnalysisVC.swift
//  Care4Wounds
//
//  Created by David Furman on 11/9/15.
//  Copyright © 2015 UCI App Jam Team 5. All rights reserved.
//

import UIKit

class PhotoAnalysisVC: UIViewController {
    var image : UIImage!
    var wound : Wound! //This is put here in case it's needed.
    var woundPhoto : WoundPhoto!
    
    @IBAction func saveButtonPressed(sender: UIButton) {
        //UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil) // Do we want to do this?
        
        // Add wound photo to Core Data
        let woundPhoto = CoreDataHelper.insertManagedObject("WoundPhoto") as! WoundPhoto
        woundPhoto.photoImage = UIImageJPEGRepresentation(image, 1)
        
        // Provide confirmation to user if the save was successful
        let success = CoreDataHelper.saveData()
        if (success) {
            let alert : UIAlertController = UIAlertController(title: "Saved!", message: "Your picture was saved", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "Ok", style: .Cancel, handler: {(action) in})
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        navigationController?.popToViewController(WoundOptionsVC.self(), animated: true)
    }
}
