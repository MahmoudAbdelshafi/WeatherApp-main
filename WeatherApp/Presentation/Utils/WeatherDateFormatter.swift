//
//  WeatherDateFormatter.swift
//  WeatherApp
//
//  Created by Mahmoud Abdelshafi on 30/12/2023.
//

import Foundation

struct WeatherDateFormatter {
    
    static func formate(date: Date, with pattern: DatePattern) -> String {
        let dateFormatter        = DateFormatter()
        dateFormatter.locale     = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = pattern.rawValue
        return dateFormatter.string(from: date)
    }
    
    static func date(from string: String, with pattern: DatePattern = DatePattern.yyyyDashMMDashdd) -> Date? {
        let jsonDateFormat = pattern.rawValue
        let formatter = Date.formatter()
        formatter.dateFormat = jsonDateFormat
        return formatter.date(from: string)
    }
    
}

enum DatePattern: String {
    case yyyyDashMMDashdd = "yyyy-MM-dd HH:MM"
    /// ex: Saturday 25 February 2021 10:00 AM
    case EEEEddMMMMyyy = "EEEE, dd MMMM yyyy"
    case yyyyMMdd = "yyyy-MM-dd"
    case time = "HH:mm a"
}
