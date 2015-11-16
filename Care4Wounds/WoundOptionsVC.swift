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
    @IBOutlet weak var viewDataButton: UIButton!
    @IBOutlet weak var viewSymptomsButton: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = wound.bodyLocation
        
        let predicate = NSPredicate(format: "wound == %@", wound!)
        
        let hasPhotos = CoreDataHelper.fetchNumberOfEntities("WoundPhoto", predicate: predicate) > 0
        viewDataButton.enabled = hasPhotos
        viewSymptomsButton.enabled = hasPhotos
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
    }
    
    @IBAction func cameraButtonPressed(sender: UIButton) {
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = .Camera
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @objc func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
        imagePicker.visibleViewController!.view.addSubview(activityIndicator)
        imagePicker.cameraOverlayView = activityIndicator
        
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        let imageData = UIImageJPEGRepresentation(image!, 1)
        let woundPhoto = createWoundPhoto(imageData!)
        
        let photoDetail = PhotoDetailVC(nibName: "PhotoDetailVC", bundle: nil)
        photoDetail.woundPhoto = woundPhoto
        
        activityIndicator.stopAnimating()
        
        self.navigationController!.pushViewController(photoDetail, animated: true)
        
        let concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        dispatch_async(concurrentQueue, {
            self.imagePicker.dismissViewControllerAnimated(false, completion: nil)
        })
    }
    
    func createWoundPhoto(imageData : NSData) -> WoundPhoto {
        let woundPhoto = CoreDataHelper.insertManagedObject("WoundPhoto") as! WoundPhoto
        woundPhoto.date = NSDate()
        woundPhoto.wound = wound
        woundPhoto.photoImage = imageData
        return woundPhoto
    }
    
    @IBAction func dataButtonPressed(sender: UIButton) {
        let woundDataVC = WoundDataVC(nibName: "WoundDataVC", bundle: nil)
        woundDataVC.wound = wound
        navigationController!.pushViewController(woundDataVC, animated: true);
    }
    
    @IBAction func symptomsButtonPressed(sender: UIButton) {
        let symptomsVC = SymptomsVC(nibName: "SymptomsVC", bundle: nil)
        let mostRecentPhoto = Wound.getPhotoBasedOnTime(wound, basedOnRecency: false)
        symptomsVC.woundPhoto = mostRecentPhoto
        navigationController!.pushViewController(symptomsVC, animated: true)
    }
}