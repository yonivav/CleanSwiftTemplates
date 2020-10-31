//
//  UserModel.swift
//  CleanSwiftExample
//
//  Created by Yoni Vizel on 10/31/20.
//

import Foundation

struct User: Codable {
    let name: String
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    let phone_number: String
    let age: Int
    let facebookLink: String
    let token: String
    let isInRelationship: Bool
}
