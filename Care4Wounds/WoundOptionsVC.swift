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
    @IBOutlet weak var viewDataButton: UIButton!
    @IBOutlet weak var viewSymptomsButton: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = wound.bodyLocation
        
        let predicate = NSPredicate(format: "wound == %@", wound!)
        
        let hasPhotos = CoreDataHelper.fetchNumberOfEntities("WoundPhoto", predicate: predicate) > 0
        viewPhotosButton.enabled = hasPhotos
        viewDataButton.enabled = hasPhotos
        viewSymptomsButton.enabled = hasPhotos
    }
    
    @IBAction func cameraButtonPressed(sender: UIButton) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: false, completion: nil)
    }
    
    @objc func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        let imageData = UIImagePNGRepresentation(image!)
        //TODO: insert loading animation here
        LoadingOverlay.shared.showOverlay(imagePicker.view)
        let woundPhoto = createWoundPhoto(imageData!)
        LoadingOverlay.shared.hideOverlayView()
        
        imagePicker.dismissViewControllerAnimated(false, completion: nil)
        
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


import UIKit
import Foundation


public class LoadingOverlay{
    
    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    class var shared: LoadingOverlay {
        struct Static {
            static let instance: LoadingOverlay = LoadingOverlay()
        }
        return Static.instance
    }
    
    public func showOverlay(view: UIView!) {
        overlayView = UIView(frame: UIScreen.mainScreen().bounds)
        overlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        activityIndicator.center = overlayView.center
        overlayView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        view.addSubview(overlayView)
    }
    
    public func hideOverlayView() {
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
}
