//
//  StringExt.swift
//  immo-rechner
//
//  Created by Mustafa Gercek on 05.02.23.
//

import Foundation

extension String{
     func toCurrency() -> String {
        if let intValue = Double(self){
            let f = NumberFormatter()
            f.numberStyle = .currency
            f.locale = Locale(identifier: "de_DE")
            f.maximumFractionDigits = 2
            f.maximumIntegerDigits = 10
           return f.string(from: NSNumber(value: intValue)) ?? ""
      }
    return ""
  }
}
