//
//  String+orEmpty.swift
//  MoveOn
//
//  Created by Garry on 15/11/22.
//

import Foundation

extension Optional where Wrapped == String {
    func orEmpty() -> String {
        return self ?? ""
    }
}
