//
//  AccountModel.swift
//  bank
//
//  Created by Sunggon Park on 2024/03/26.
//

import Foundation

enum AccountType: String {
    case Banking
    case CreditCard
    case Investment
}

struct AccountModel {
    let accountType: AccountType
    let accountName: String
    let balance: Decimal
}
