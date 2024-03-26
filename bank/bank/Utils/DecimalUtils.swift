//
//  DecimalUtils.swift
//  bank
//
//  Created by Sunggon Park on 2024/03/26.
//

import UIKit

extension Decimal {
    var doubleValue: Double {
        NSDecimalNumber(decimal: self).doubleValue
    }
}
