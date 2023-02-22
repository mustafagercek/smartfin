//
//  DateExt.swift
//  immo-rechner
//
//  Created by Mustafa Gercek on 22.01.23.
//

import Foundation
extension Date {
    func addYear(n: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .year, value: n, to: self)!
    }
    
    func addMonth(n: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .month, value: n, to: self)!
    }
    
    func startOfMonth() -> Date {
        let calendar = Calendar.current
        return calendar.date(from: calendar.dateComponents([.year, .month], from: self))!
    }
    
    func endOfMonth(_ date: Date) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    func MM_YY() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "de_DE")
        dateFormatter.dateFormat = "MM.YY"
        return dateFormatter.string(from: self)
    }
    
    func monthValue() -> Int {
        return Calendar.current.dateComponents([.month], from: self).month ?? -1
    }

}
