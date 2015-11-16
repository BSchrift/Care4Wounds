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
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func continueToConcerns(sender: UIButton) {
    let concernsVC = ConcernsVC(nibName: "ConcernsVC", bundle: nil)
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
