//
//  DateUtils.swift
//  Bank
//
//  Created by Sunggon Park on 2024/03/28.
//

import Foundation

extension Date {
    static var bankDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "JST")
        
        return formatter
    }
    
    var monthDayYearString: String {
        let dateFormatter = Date.bankDateFormatter
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        return dateFormatter.string(from: self)
    }
}
