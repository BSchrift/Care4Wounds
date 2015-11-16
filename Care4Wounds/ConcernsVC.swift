//
//  ConcernsVC.swift
//  Care4Wounds
//
//  Created by Benjamin Schrift on 11/15/15.
//  Copyright © 2015 UCI App Jam Team 5. All rights reserved.
//

import UIKit

class ConcernsVC: UIViewController {
  
  var doctorInfo:DoctorInfo = DoctorInfo()
  
  @IBOutlet weak var painLevel: UISlider!
  @IBOutlet weak var warmth: UISlider!
  @IBOutlet weak var odor: UISwitch!
  @IBOutlet weak var swelling: UISwitch!
  @IBOutlet weak var fever: UISwitch!
  @IBOutlet weak var separation: UISwitch!
  @IBOutlet weak var additionalConcerns: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    additionalConcerns.layer.borderColor = UIColor.grayColor().CGColor
    additionalConcerns.layer.borderWidth = 2.3
    additionalConcerns.layer.cornerRadius = 15
    painLevel.minimumValue = 0
    painLevel.maximumValue = 10
    warmth.minimumValue = 0
    warmth.maximumValue = 10
    
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
    view.addGestureRecognizer(tap)
    
    
    // Do any additional setup after loading the view.
  }
  
  //Calls this function when the tap is recognized.
  func dismissKeyboard() {
    //Causes the view (or one of its embedded text fields) to resign the first responder status.
    view.endEditing(true)
  } 
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  @IBAction func submit(sender: UIButton) {
    doctorInfo.painLevel = Int(painLevel.value)
    doctorInfo.warmth = Int(warmth.value)
    doctorInfo.odor = odor.on
    doctorInfo.swelling = swelling.on
    doctorInfo.fever = fever.on
    doctorInfo.separation = separation.on
    doctorInfo.additionalConcerns = additionalConcerns.text ?? doctorInfo.additionalConcerns
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
