//
//  WoundPhoto+CoreDataProperties.swift
//  Care4Wounds
//
//  Created by David Furman on 11/9/15.
//  Copyright © 2015 UCI App Jam Team 5. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension WoundPhoto {

    @NSManaged var levelOfPain: NSNumber?
    @NSManaged var photoImage: NSData?
    @NSManaged var woundSize: NSNumber?
    @NSManaged var timeTaken: NSDate?
    @NSManaged var miscComments: String?
    @NSManaged var wound: Wound?

}
