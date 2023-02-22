//
//  RepaymentPlanOverview.swift
//  immo-rechner
//
//  Created by Mustafa Gercek on 22.01.23.
//

import Foundation

struct RepaymentPlan {
    let monthlyPayment: Float
    let yearlyPayment: Float // 12 * monthly
    let totalPayment: Float // yearly * loan.duration
    let remainingDebt: Float
    let totalInterestPayment: Float
    let totalAmortizationPayment: Float
    // let monthlySteps: [RepaymentPlanStep]
}
