//
//  WoundPhoto+CoreDataProperties.swift
//  Care4Wounds
//
//  Created by David Furman on 11/12/15.
//  Copyright © 2015 UCI App Jam Team 5. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension WoundPhoto {

    @NSManaged var date: NSDate?
    @NSManaged var hasBadOdor: NSNumber?
    @NSManaged var hasFever: NSNumber?
    @NSManaged var hasFluidDrainage: NSNumber?
    @NSManaged var hasPain: NSNumber?
    @NSManaged var hasPus: NSNumber?
    @NSManaged var hasRedness: NSNumber?
    @NSManaged var hasSwelling: NSNumber?
    @NSManaged var hasWarmth: NSNumber?
    @NSManaged var levelOfPain: NSNumber?
    @NSManaged var photoImage: NSData?
    @NSManaged var woundLength: NSNumber?
    @NSManaged var levelOfConcern: NSNumber?
    @NSManaged var wound: Wound?

}
