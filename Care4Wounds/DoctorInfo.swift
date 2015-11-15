//
//  DoctorInfo.swift
//  Care4Wounds
//
//  Created by Benjamin Schrift on 11/14/15.
//  Copyright © 2015 UCI App Jam Team 5. All rights reserved.
//

import Foundation

class DoctorInfo {
  var wound : Wound?
  var concernLevel: ConcernLevelVC.concernLevels
  var isDraining: Bool
  var drainageColor: String
  var drainageType: String
  
  init() {
    wound = nil;
    concernLevel = ConcernLevelVC.concernLevels.unconcerned
    isDraining = false
    drainageColor = "Invalid: not draining"
    drainageType = "Invalid: not draining"
  }
}