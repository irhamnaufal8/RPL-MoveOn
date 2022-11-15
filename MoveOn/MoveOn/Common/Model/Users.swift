//
//  Users.swift
//  MoveOn
//
//  Created by Garry on 15/11/22.
//

import Foundation

struct User: Codable {
    var id: String?
    var email: String?
    var username: String?
    var password: String?
    var profilePictureUrl: String?
    var phoneNumber: String?
}
