//
//  ProfileModel.swift
//  Bank
//
//  Created by Sunggon Park on 2024/03/28.
//

import Foundation


struct Profile: Codable {
    let id: String
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
