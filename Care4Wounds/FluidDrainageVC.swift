//
//  FluidDrainageVC.swift
//  Care4Wounds
//
//  Created by Benjamin Schrift on 11/14/15.
//  Copyright © 2015 UCI App Jam Team 5. All rights reserved.
//

import UIKit

class FluidDrainageVC: UIViewController {
  
  @IBOutlet weak var isDraining: UISwitch!
  @IBOutlet weak var colorField: UITextField!
  @IBOutlet weak var typeField: UITextField!
  @IBOutlet weak var menu: UIView!
  
  var doctorInfo:DoctorInfo = DoctorInfo()

  override func viewDidLoad() {
    super.viewDidLoad()
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
  
  @IBAction func continueToConcerns(sender: UIButton) {
    let concernsVC = ConcernsVC(nibName: "ConcernsVC", bundle: nil)
    doctorInfo.isDraining = !menu.hidden
    doctorInfo.drainageColor = colorField.text ?? doctorInfo.drainageColor
    doctorInfo.drainageType = typeField.text ?? doctorInfo.drainageType
    concernsVC.doctorInfo = doctorInfo
    navigationController!.pushViewController(concernsVC, animated: true)
    
  }
  @IBAction func isDrainingChanged(sender: UISwitch) {
    menu.hidden = !menu.hidden
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
