//
//  CoreDataHelper.swift
//  ClientManager
//
//  Created by David Furman on 6/18/15.
//
//

import UIKit
import CoreData

class CoreDataHelper : NSObject {
	
	static var moc : NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
	
    /** Inserts a managed object into the managed object context moc, then returns it. This insertion must be saved using saveData() for the change to persist when the application closes! */
	static func insertManagedObject(className: String) -> NSManagedObject {
		let managedObject = NSEntityDescription.insertNewObjectForEntityForName(className, inManagedObjectContext: moc) as NSManagedObject
		return managedObject
	}
	
    /** Returns an array of managed objects. If an NSPredicate is supplied, the array will be filtered based upon the predicate. */
	static func fetchEntities(className: String, predicate: NSPredicate?) -> [NSManagedObject] {
		let fetchRequest = NSFetchRequest()
		
		let entityDescription = NSEntityDescription.entityForName(className, inManagedObjectContext: moc)
		
		fetchRequest.entity = entityDescription
		
		if predicate != nil {
			fetchRequest.predicate = predicate!
		}
		
		fetchRequest.returnsObjectsAsFaults = false
		
		do {
			let entities = try moc.executeFetchRequest(fetchRequest) as![NSManagedObject]
			return entities
		} catch {
			fatalError("Error executing fetch request")
		}
	}
	
    /** Returns the number of entities that exist matching a certain entity name and, if supplied, a predicate. */
	static func fetchNumberOfEntities(className: String, managedObjectContext: NSManagedObjectContext, predicate: NSPredicate?) -> Int {
		let fetchRequest = NSFetchRequest()
		fetchRequest.resultType = .CountResultType
		let entityDescription = NSEntityDescription.entityForName(className, inManagedObjectContext: managedObjectContext)
		
		fetchRequest.entity = entityDescription
		
		if predicate != nil {
			fetchRequest.predicate = predicate!
		}
		
		fetchRequest.returnsObjectsAsFaults = false
		
		do {
			let countArray = try managedObjectContext.executeFetchRequest(fetchRequest)
			let count = countArray[0].integerValue!
			return count
		} catch {
			fatalError("Error executing fetch request")
		}
	}
    
    /** Saves the managed object context by applying any changes that have been made to the managed object context. */
    static func saveData() -> Bool {
        do {
            try moc.save()
            return true
        } catch {
            print("ERROR saving the managed object context in method saveData().")
            return false
        }
    }
}