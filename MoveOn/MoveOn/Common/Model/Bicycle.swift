//
//  Bicycle.swift
//  MoveOn
//
//  Created by Garry on 23/12/22.
//

import Foundation
import Firebase

struct Bicycle: Identifiable, Codable {
    var id: String?
    var location: GeoPoint?
    var name: String?
    var price: Int?
    var usedBy: String?
}
