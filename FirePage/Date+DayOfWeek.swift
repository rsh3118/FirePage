//
//  Date+DayOfWeek.swift
//  FirePage
//
//  Created by The Ritler on 12/28/16.
//  Copyright © 2016 The Ritler. All rights reserved.
//


import Foundation
extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
}
