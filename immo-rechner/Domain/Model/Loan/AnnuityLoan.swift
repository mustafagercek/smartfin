//
//  Loan.swift
//  immo-rechner
//
//  Created by Mustafa Gercek on 22.01.23.
//

import Foundation

struct AnnuityLoan:Hashable {
    let startDate: Date
    let amount: Float
    let interestRate: Float
    let amortizationRate: Float
    let years: Int
    
    private var m_amortization: Float
    private var m_i: Float
    private var m_a: Float
    
    init(startDate: Date, amount: Float, interestRate: Float, amortizationRate: Float, years: Int) {
        self.startDate = startDate
        self.amount = amount
        self.interestRate = interestRate
        self.amortizationRate = amortizationRate
        self.years = years
        self.m_i = interestRate/12.0
        self.m_a = amortizationRate/12.0
        self.m_amortization = amount * m_a
    }
    
    func getMonthlyPayment()->Float{
        let totalRate = amortizationRate + interestRate
        let yearlyPayment = amount * totalRate
        return yearlyPayment/12.0
    }
    
    func getRemeiningDebt(forMonth: Int)->Float {
        return max(amount - getAmortization(forMonth: forMonth),0)
    }
    
    func getAmortization(forMonth: Int)->Float{
        return amount * m_a * ((pow(1+m_i, Float(forMonth))-1)/m_i)
    }
    
    static func == (lhs: AnnuityLoan, rhs: AnnuityLoan) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
