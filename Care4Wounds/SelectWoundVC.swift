//
//  SelectWoundVC.swift
//  Care4Wounds
//
//  Created by Benjamin Schrift on 11/13/15.
//  Copyright © 2015 UCI App Jam Team 5. All rights reserved.
//

import UIKit

class SelectWoundVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
  
  var wounds = [Wound]()
  var doctorInfo = DoctorInfo()
  
  @IBOutlet weak var selectButton: UIButton!
  @IBOutlet weak var pickerView: UIPickerView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    pickerView.dataSource = self
    pickerView.delegate = self
    
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    CoreDataHelper.rollBack()
    wounds = CoreDataHelper.fetchEntities("Wound", predicate: nil) as! [Wound]
    pickerView.reloadAllComponents()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func selectWoundPressed(sender: UIButton) {
    navigationController?.popToRootViewControllerAnimated(true)
    let woundDataVC = WoundDataVC(nibName: "WoundDataVC", bundle: nil)
    woundDataVC.wound = wounds[pickerView.selectedRowInComponent(0)]
    navigationController!.pushViewController(woundDataVC, animated: true);
    woundDataVC.presentMailVC()

  }
  
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return wounds.count
  }
  
  func pickerView(pickerView: UIPickerView,
    titleForRow row: Int,
    forComponent component: Int) -> String? {
      return wounds[row].bodyLocation
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
