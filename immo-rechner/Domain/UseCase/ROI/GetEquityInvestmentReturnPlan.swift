//
//  GetEquityROI.swift
//  immo-rechner
//  Created by Mustafa Gercek on 23.01.23.
//
// K = R ∗ q ∗ (q^[n−1]−1)/(q−1) + I ∗ qn
// K = Endkapital
// R = Jährliche Sparrate
// q = Zins
// n = Laufzeit in Jahren
// I = Initial

import Foundation

protocol GetEquityInvestmentReturnPlan {
    func getReturnPlan(investment: EquityInvestment) -> EquityInvestmentReturnPlan
    func getYearlyReturnSteps(investment: EquityInvestment) -> [EquityInvestmentReturnStep]
}

struct GetEquityInvestmentReturnPlanUseCase: GetEquityInvestmentReturnPlan {
    
    func getYearlyReturnSteps(investment: EquityInvestment) -> [EquityInvestmentReturnStep] {
        let stepCount = investment.years
        var steps = [EquityInvestmentReturnStep]()
        let q = investment.expectedReturnRatio + 1
        let I = investment.initial
        let R = calc_R(monthly: investment.monthlyContribution, r: investment.expectedReturnRatio)
        for i in 1...stepCount {
            let contribution = investment.monthlyContribution * 12
            let newAmount = calc_K(n: i, q: q, I: I, R: R)
            var previously: Float
            if i == 1 {
                previously = I
            } else {
                previously = calc_K(n: i-1, q: q, I: I, R: R)
            }
            let interest = newAmount - previously - contribution
            
            let step = EquityInvestmentReturnStep(
                yearNr: i,
                contribution: contribution.roundedValue(),
                interest: interest.roundedValue(),
                newAmount: newAmount.roundedValue())
            
            steps.append(step)
        }
        return steps
    }
    
    func getReturnPlan(investment: EquityInvestment) -> EquityInvestmentReturnPlan {
        
        let n = investment.years
        let q = 1+investment.expectedReturnRatio
        let I = investment.initial
        let R = calc_R(monthly: investment.monthlyContribution, r: investment.expectedReturnRatio)
        let K = calc_K(n: n, q: q, I: I, R: R)
        
        let receivedInterest = K - (I+Float(n)*investment.monthlyContribution*12)
        return EquityInvestmentReturnPlan(endValue: K.roundedValue(),
                                          receivedInterest: receivedInterest.roundedValue(),
                                          totalContribution: K-receivedInterest-I)
    }
    
    private func calc_K(n: Int, q: Float, I: Float, R: Float)->Float {
        return I * pow(q, Float(n)) + R * ((pow(q, Float(n))-1)/(q-1))
    }
    
    private func calc_R(monthly: Float, r: Float) -> Float {
        return monthly * 12 + monthly * r/12 * 78
    }

}
