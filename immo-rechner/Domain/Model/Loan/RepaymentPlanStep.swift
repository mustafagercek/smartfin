//
//  RepaymentPlanSteps.swift
//  immo-rechner
//
//  Created by Mustafa Gercek on 22.01.23.
//

import Foundation

struct RepaymentPlanStep:Hashable,Identifiable {
    let date:Date
    let amortization: Float
    let interest: Float
    let remainingDebt: Float
    
    var id: String {
        date.formatted()
    }
    
    static func == (lhs: RepaymentPlanStep, rhs: RepaymentPlanStep) -> Bool {
        return lhs.id == rhs.id
    }
}
