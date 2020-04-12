//
//  Date+Extensions.swift
//  RedditTop
//
//  Created by Vladyslav Skintiyan on 12.04.2020.
//  Copyright © 2020 Vladyslav Skintiyan. All rights reserved.
//

import Foundation

extension Date {
    static func agoHoursString(with calendar: Calendar = Calendar.current, from fromDate: Date, to toDate: Date = Date()) -> String {
        let components = calendar.dateComponents([.hour], from: fromDate, to: toDate)

        let result: String
        if let hour = components.hour, hour >= 1 {
            result = "\(hour)h ago"
        } else {
            result = "Recently"
        }
        
        return result
    }
}
