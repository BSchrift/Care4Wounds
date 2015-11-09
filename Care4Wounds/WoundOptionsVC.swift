//
//  WoundOptionsVC.swift
//  Care4Wounds
//
//  Created by David Furman on 11/9/15.
//  Copyright © 2015 UCI App Jam Team 5. All rights reserved.
//

import UIKit

class WoundOptionsVC : UIViewController {
    var wound : Wound!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = wound.bodyLocation
    }
    
    @IBAction func cameraButtonPressed(sender: UIButton) {
        let camVC = CameraVC(nibName: "CameraVC", bundle: nil)
        camVC.wound = wound
        navigationController?.pushViewController(camVC, animated: true);
    }
    
    @IBAction func photosButtonPressed(sender: UIButton) {
        let photosVC = PhotosVC(nibName: "PhotosVC", bundle: nil)
        photosVC.wound = wound
        navigationController?.pushViewController(photosVC, animated: true);
    }
    
    @IBAction func dataButtonPressed(sender: UIButton) {
        let woundDataVC = WoundDataVC(nibName: "WoundDataVC", bundle: nil)
        woundDataVC.wound = wound
        navigationController?.pushViewController(woundDataVC, animated: true);
    }
    
    // I'm not sure if the symptoms should all be in one View Controller. I'm waiting on more information about that before setting that up - David Furman
    @IBAction func symptomsButtonPressed(sender: UIButton) {
        /*let symptomsVC = SymptomsVC(nibName: "SymptomsView", bundle: nil)
        symptomsVC.wound = wound
        navigationController?.pushViewController(SymptomsVC, animated: true);*/
    }
}
