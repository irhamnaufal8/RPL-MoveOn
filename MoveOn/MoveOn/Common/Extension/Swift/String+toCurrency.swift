//
//  String+toCurrency.swift
//  MoveOn
//
//  Created by Garry on 23/12/22.
//

import Foundation
import CurrencyFormatter

extension Double {
    func toCurrency() -> String {
        let fm = CurrencyFormatter()

        fm.currency = .rupiah
        fm.locale = CurrencyLocale.indonesian
        fm.decimalDigits = 0

        return fm.string(from: self).orEmpty()
    }
}

extension String {
    func toCurrency() -> String {
        let fm = CurrencyFormatter()
        
        fm.currency = .rupiah
        fm.locale = CurrencyLocale.indonesian
        fm.decimalDigits = 0
        
        return fm.string(from: Double.init(Int.init(self).orZero())).orEmpty()
    }
    
    func toPriceFormat() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "id_ID")
        
        if let number = formatter.string(from: Double.init(Int.init(self).orZero())) {
            return number.replacingOccurrences(of: "Rp", with: "")
        } else {
            return ""
        }
    }
}
