//
//  Int+orZero.swift
//  MoveOn
//
//  Created by Garry on 15/11/22.
//

import SwiftUI

extension Optional where Wrapped == Int {
    func orZero() -> Int {
        return self ?? 0
    }
}
