//
//  AccountModel.swift
//  bank
//
//  Created by Sunggon Park on 2024/03/26.
//

import Foundation

enum AccountType: String, Codable  {
    case Banking
    case CreditCard
    case Investment
}

struct Account: Codable {
    let id: String
    let type: AccountType
    let name: String
    let amount: Decimal
    let createdDateTime: Date
    
    static func makeSkeleton() -> Account {
        return Account(id: "1", type: .Banking, name: "Account name", amount: 0.0, createdDateTime: Date())
    }
}


struct AccountModel {
    let accountType: AccountType
    let accountName: String
    let balance: Decimal
}
