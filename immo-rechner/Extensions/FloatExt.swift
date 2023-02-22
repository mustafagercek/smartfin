//
//  FloatExtensions.swift
//  immo-rechner
//
//  Created by Mustafa Gercek on 22.01.23.
//

import Foundation

extension Float {
    
    func roundedValue() -> Float {
        return (self*100).rounded()/100.0
    }
    
    func toCurrency() -> String {
        let f = NumberFormatter()
        f.numberStyle = .currency
        f.locale = Locale(identifier: "de_DE")
        f.maximumFractionDigits = 2
        f.maximumIntegerDigits = 10
        return f.string(from: NSNumber(value: self)) ?? ""
    }
}
