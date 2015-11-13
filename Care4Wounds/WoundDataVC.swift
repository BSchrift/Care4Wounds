//
//  WoundDataVC.swift
//  Care4Wounds
//
//  Created by David Furman on 11/9/15.
//  Copyright © 2015 UCI App Jam Team 5. All rights reserved.
//

import UIKit

class WoundDataVC: UIViewController {
    var wound : Wound!
    
    @IBOutlet weak var firstPicture: UIImageView!
    @IBOutlet weak var currentPicture: UIImageView!
    
    var firstWoundPhoto : WoundPhoto?
    var currentWoundPhoto : WoundPhoto?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Wound Data"
        
        loadPhotos()
    }
    
    func loadPhotos() {
        let earliestPhoto : WoundPhoto? = Wound.getPhotoBasedOnTime(wound, basedOnRecency: true)
        let latestPhoto : WoundPhoto? = Wound.getPhotoBasedOnTime(wound, basedOnRecency: false)
        
        firstPicture.image   = (earliestPhoto != nil) ? UIImage(data: (earliestPhoto!.photoImage!)) : UIImage(named: "error.png")
        currentPicture.image = (latestPhoto != nil)   ? UIImage(data: (latestPhoto!.photoImage!))   : UIImage(named: "error.png")
    }
}
