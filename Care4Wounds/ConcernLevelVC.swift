//
//  ConcernLevelVC.swift
//  Care4Wounds
//
//  Created by Benjamin Schrift on 11/13/15.
//  Copyright © 2015 UCI App Jam Team 5. All rights reserved.
//

import UIKit

class ConcernLevelVC: UIViewController {
  
  enum concernLevels {
    case unconcerned
    case worried
    case veryconcerned
  }
  
  var doctorInfo:DoctorInfo = DoctorInfo()
  
  @IBAction func veryConcernedPressed(sender: UIButton) {
    doctorInfo.concernLevel = concernLevels.veryconcerned
    transitionToFluidDrainage()
  }
  @IBAction func worriedPressed(sender: UIButton) {
    doctorInfo.concernLevel = concernLevels.worried
    transitionToFluidDrainage()
  }
  @IBAction func unconcernedPressed(sender: UIButton) {
    doctorInfo.concernLevel = concernLevels.unconcerned
    transitionToFluidDrainage()
  }
  
  func transitionToFluidDrainage() {
    let fluidDrainageVC = FluidDrainageVC(nibName: "FluidDrainageVC", bundle: nil)
    navigationController!.pushViewController(fluidDrainageVC, animated: true)
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
}
