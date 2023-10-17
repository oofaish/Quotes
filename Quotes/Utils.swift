//
//  Utils.swift
//  Quotes
//
//  Created by Ali on 12/10/2023.
//

import Foundation

func daysSinceSometimeIn2023() -> Int {
    let currentDate = Date()
    let secondsSince1970 = currentDate.timeIntervalSince1970
    let days = Int(secondsSince1970 / 86400)
    // subtracting todays date to give me some time to add more
    // musings before there is a rotation.
    return days - 19642
}
