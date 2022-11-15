//
//  String+toURL.swift
//  MoveOn
//
//  Created by Garry on 15/11/22.
//

import Foundation

extension String {
    func toURL() -> URL? {
        return URL(string: self)
    }
}
