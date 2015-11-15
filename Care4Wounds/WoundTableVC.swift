//
//  WoundTableVC.swift
//  Care4Wounds
//
//  Created by David Furman on 11/8/15.
//  Copyright © 2015 UCI App Jam Team 5. All rights reserved.
//

import UIKit
import CoreData

class WoundTableVC : UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let moc : NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var wounds = [Wound]()
    var newWoundLocation : String?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: Selector("showAddWoundAlert"))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.title = "Wounds"
    }
    
    override func viewWillAppear(animated : Bool) {
        super.viewWillAppear(animated)
        CoreDataHelper.rollBack()
        wounds = CoreDataHelper.fetchEntities("Wound", predicate: nil) as! [Wound]
        tableView.reloadData()
    }
    
    // MARK: UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wounds.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        let wound = wounds[indexPath.row]
        cell!.textLabel!.text = wound.valueForKey("bodyLocation") as? String
        return cell!
    }
    
    func showAddWoundAlert() {
        let alertController : UIAlertController = UIAlertController(title: "Adding a wound", message: "Enter the location of the wound", preferredStyle: .Alert)

        let addWoundAction = UIAlertAction(title: "Add Wound", style: .Default) { (_) -> Void in
            let woundOptionsVC = WoundOptionsVC(nibName: "WoundOptionsVC", bundle: nil)
            let wound = self.createWound()
            woundOptionsVC.wound = wound
            self.navigationController!.pushViewController(woundOptionsVC, animated: true)
        }
        addWoundAction.enabled = false

        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        alertController.addAction(addWoundAction)
        alertController.addAction(cancelAction)

        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Body Location"
            
            NSNotificationCenter.defaultCenter().addObserverForName(UITextFieldTextDidChangeNotification, object: textField, queue: NSOperationQueue.mainQueue()) { (notification) in
                self.newWoundLocation = textField.text
                addWoundAction.enabled = textField.text != ""
            }
        }
        presentViewController(alertController, animated: true, completion: nil)
    }
    
  func createWound() -> Wound {
    let entities = CoreDataHelper.fetchNumberOfEntities("Wound", predicate: nil)
    let wound = CoreDataHelper.insertManagedObject("Wound") as! Wound
    wound.bodyLocation = self.newWoundLocation
    CoreDataHelper.saveData()
    return wound
  }
  
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let woundOptionsVC = WoundOptionsVC(nibName: "WoundOptionsVC", bundle: nil)
        woundOptionsVC.wound = wounds[indexPath.row]
        navigationController!.pushViewController(woundOptionsVC, animated: true)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let woundToRemove = wounds[indexPath.row]
        CoreDataHelper.deleteManagedObject(woundToRemove)
        wounds.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
}