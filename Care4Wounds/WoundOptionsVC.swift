//
//  WoundOptionsVC.swift
//  Care4Wounds
//
//  Created by David Furman on 11/9/15.
//  Copyright © 2015 UCI App Jam Team 5. All rights reserved.
//

import UIKit

class WoundOptionsVC : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var wound : Wound!
    var imagePicker: UIImagePickerController!
    @IBOutlet weak var viewPhotosButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = wound.bodyLocation
    }
    
    @IBAction func cameraButtonPressed(sender: UIButton) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: false, completion: nil)
    }
    
    @objc func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(false, completion: nil)
        
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        let imageData = UIImagePNGRepresentation(image!)
        //TODO: insert loading animation here
        let woundPhoto = createWoundPhoto(imageData!)
        
        let photoDetail = PhotoDetailVC(nibName: "PhotoDetailVC", bundle: nil)
        photoDetail.woundPhoto = woundPhoto
        navigationController!.pushViewController(photoDetail, animated: false)
    }
    
    func createWoundPhoto(imageData : NSData) -> WoundPhoto {
        let woundPhoto = CoreDataHelper.insertManagedObject("WoundPhoto") as! WoundPhoto
        woundPhoto.date = NSDate()
        woundPhoto.wound = wound
        woundPhoto.photoImage = imageData
        return woundPhoto
    }
    
    @IBAction func photosButtonPressed(sender: UIButton) {
        let photosVC = PhotosVC(nibName: "PhotosVC", bundle: nil)
        photosVC.wound = wound
        navigationController!.pushViewController(photosVC, animated: true);
    }
    
    @IBAction func dataButtonPressed(sender: UIButton) {
        let woundDataVC = WoundDataVC(nibName: "WoundDataVC", bundle: nil)
        woundDataVC.wound = wound
        navigationController!.pushViewController(woundDataVC, animated: true);
    }
    
    @IBAction func symptomsButtonPressed(sender: UIButton) {
        let symptomsVC = SymptomsVC(nibName: "SymptomsVC", bundle: nil)
        let mostRecentPhoto = Wound.getPhotoBasedOnTime(wound, basedOnRecency: true)
        symptomsVC.woundPhoto = mostRecentPhoto
        navigationController!.pushViewController(symptomsVC, animated: true)
    }
}
