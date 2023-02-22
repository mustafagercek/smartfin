//
//  GetBuyOrRentResult.swift
//  immo-rechner
//
//  Created by Mustafa Gercek on 23.01.23.
//

import Foundation

protocol GetRentPaymentPlan {
    func getRentPaymentPlan(rent: Rent) -> RentPaymentPlan
}

struct GetRentPaymentPlanUseCase: GetRentPaymentPlan {
    
    private let fm = FormulaManager.shared
    
    func getRentPaymentPlan(rent: Rent) -> RentPaymentPlan {
        let r = rent.baseRent * 12
        let n = Float(rent.years)
        let q = 1 + (rent.increaseRate ?? 0.0)
        
        let totalPayment = r * fm.calc_endwertfaktor_nachschuessig(q: q, n: n)
        let futureYearlyRent = r * pow(q, n-1)
        let futureMonthlyRent = futureYearlyRent/12.0
        
        return RentPaymentPlan(
            totalRentPayment: totalPayment.roundedValue(),
            futureYearlyRent: futureYearlyRent.roundedValue(),
            futureMonthlyRent: futureMonthlyRent.roundedValue())
    }
}
