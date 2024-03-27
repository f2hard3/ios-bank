//
//  AccountSummaryHeaderModel.swift
//  Bank
//
//  Created by Sunggon Park on 2024/03/28.
//

import Foundation

struct AccountSummaryHeaderModel {
    let welcomeMessage: String
    let name: String
    let date: Date
    
    var dateFormmated: String {
        return date.monthDayYearString
    }
}
