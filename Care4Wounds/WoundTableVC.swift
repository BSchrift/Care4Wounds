//
//  WoundTableVC.swift
//  Care4Wounds
//
//  Created by David Furman on 11/8/15.
//  Copyright © 2015 UCI App Jam Team 5. All rights reserved.
//

import UIKit
import CoreData

class WoundTableVC : UIViewController, UITableViewDataSource, UITableViewDelegate {
    let moc : NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var wounds = [Wound]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: Selector("toAddWoundVC"))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.title = "Wounds"
    }
    
    override func viewWillAppear(animated : Bool) {
        super.viewWillAppear(animated)
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
    
    func toAddWoundVC() {
        let addWoundVC = AddWoundVC(nibName: "AddWoundVC", bundle: nil)
        navigationController!.pushViewController(addWoundVC, animated: true)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let woundOptionsVC = WoundOptionsVC(nibName: "WoundOptionsVC", bundle: nil)
        woundOptionsVC.wound = wounds[indexPath.row]
        navigationController!.pushViewController(woundOptionsVC, animated: true)
        
    }
}