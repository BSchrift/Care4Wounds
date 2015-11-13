//
//  Wound.swift
//  Care4Wounds
//
//  Created by David Furman on 11/9/15.
//  Copyright © 2015 UCI App Jam Team 5. All rights reserved.
//

import Foundation
import CoreData


class Wound: NSManagedObject {

    /** Gets the earliest photo from a wound */
    static func getPhotoBasedOnTime(wound : Wound, basedOnRecency : Bool) -> WoundPhoto? {
        guard wound.woundPhotos != nil else {
            return nil
        }
        
        var photoToReturn : WoundPhoto?
        let predicate = NSPredicate(format: "SELF IN %@", wound.woundPhotos!)
        let woundPhotos = CoreDataHelper.fetchEntities("WoundPhoto", predicate: predicate)
        for photo in woundPhotos as! [WoundPhoto] {
            if (photoToReturn == nil) {
                photoToReturn = photo
                continue
            }
            
            if (basedOnRecency) {
                // If photo's date is earlier than the photoToReturn
                if (photo.date!.compare(photoToReturn!.date!) == NSComparisonResult.OrderedAscending) {
                    photoToReturn = photo
                }
            } else {
                // If photo's date is later than the photoToReturn
                if (photo.date!.compare(photoToReturn!.date!) == NSComparisonResult.OrderedDescending) {
                    photoToReturn = photo
                }
            }
        }
        return photoToReturn
    }
}
