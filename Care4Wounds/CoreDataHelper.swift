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
	
	class func doesSimilarEntityExistInManagedObjectContext(entity: String, predicate: NSPredicate?) -> Bool {
		return false
	}
	
	static func insertManagedObject(className: String) -> NSManagedObject {
		let managedObject = NSEntityDescription.insertNewObjectForEntityForName(className, inManagedObjectContext: moc) as NSManagedObject
		return managedObject
	}
	
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
    
    
    static func saveData() -> Bool {
        do {
            try moc.save()
            print("TEST")
            return true
        } catch {
            print("ERROR saving the managed object context in method saveData().")
            return false
        }
    }
}