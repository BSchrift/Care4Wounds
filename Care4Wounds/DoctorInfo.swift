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
  var painLevel: Int
  var warmth: Int
  var odor: Bool
  var swelling: Bool
  var fever: Bool
  var separation: Bool
  var additionalConcerns: String
  
  init() {
    wound = nil;
    concernLevel = ConcernLevelVC.concernLevels.unconcerned
    isDraining = false
    drainageColor = "Invalid: not draining"
    drainageType = "Invalid: not draining"
    painLevel = 0
    warmth = 0
    odor = false
    swelling = false
    fever = false
    separation = false
    additionalConcerns = "None"
  }
}