//
//  RepaymentPlanUseCase.swift
//  immo-rechner
//
//  Created by Mustafa Gercek on 22.01.23.
//

import Foundation

protocol GetRepaymentPlan {
    func getRepaymentPlan(loan: AnnuityLoan) -> RepaymentPlan
    func getMonthlyPaymentSteps(loan: AnnuityLoan) -> [RepaymentPlanStep]
    func getYearlyPaymentSteps(loan: AnnuityLoan) -> [RepaymentPlanStep]
}

struct GetRepaymentPlanUseCase: GetRepaymentPlan {
    
    private let fm = FormulaManager.shared
    
    func getRepaymentPlan(loan: AnnuityLoan) -> RepaymentPlan {
        let n = Float(loan.years)
        let monthlyPayment: Float = loan.getMonthlyPayment()
        let yearlyPayment = monthlyPayment * 12.0
        let totalPayment = yearlyPayment * n
        
        let totalAmortizationPayment = min(loan.getAmortization(forMonth: loan.years*12),loan.amount)
        let remainingDebt = loan.amount - totalAmortizationPayment
        let totalInterestPayment = totalPayment - totalAmortizationPayment

        return RepaymentPlan(monthlyPayment: monthlyPayment.roundedValue(),
                             yearlyPayment: yearlyPayment.roundedValue(),
                             totalPayment: totalPayment.roundedValue(),
                             remainingDebt: remainingDebt.roundedValue(),
                             totalInterestPayment: totalInterestPayment.roundedValue(),
                             totalAmortizationPayment: totalAmortizationPayment.roundedValue())
    }
    
    func getMonthlyPaymentSteps(loan: AnnuityLoan) -> [RepaymentPlanStep] {
        let stepCount = loan.years * 12
        let start = loan.startDate
        var steps = [RepaymentPlanStep]()
        for i in 1...stepCount {
            let date = start.addMonth(n: i)
            let monthlyPayment = loan.getMonthlyPayment()
            let remainingDebt = loan.getRemeiningDebt(forMonth: i)
            var previously: Float
            if i == 1 {
                previously = loan.amount
            } else {
                previously = loan.getRemeiningDebt(forMonth: i-1)
            }
            let amortization = previously - remainingDebt
            let interest:Float
            if remainingDebt == 0{
                interest = previously * loan.interestRate/12.0
            } else {
                interest = monthlyPayment - amortization
            }
            let step = RepaymentPlanStep(
                date: date,
                amortization: amortization.roundedValue(),
                interest: interest.roundedValue(),
                remainingDebt: remainingDebt.roundedValue())
            
            steps.append(step)
            if remainingDebt == 0 {
                return steps
            }
        }
        return steps
    }
    
    func getYearlyPaymentSteps(loan: AnnuityLoan) -> [RepaymentPlanStep] {
        let monthlySteps = getMonthlyPaymentSteps(loan: loan)
        var steps = [RepaymentPlanStep]()

        var amortization:Float = 0.0
        var interest:Float = 0.0
        var remainingDebt:Float = 0.0
        
        for (i,month) in monthlySteps.enumerated() {
            amortization = amortization + month.amortization
            interest = interest + month.interest

            if month.date.monthValue() == 12 || i == monthlySteps.count-1 {
                remainingDebt = month.remainingDebt
                let step = RepaymentPlanStep(date: month.date,
                                             amortization: amortization.roundedValue(),
                                             interest: interest.roundedValue(),
                                             remainingDebt: remainingDebt.roundedValue())
                steps.append(step)
                amortization = 0
                interest = 0
                remainingDebt = 0
            }
            
        }
        
        /*
         let stepCount = loan.years
         let start = loan.startDate
        for i in 1...stepCount {
            let date = start.addYear(n: i)
            let yearlyPayment = loan.getMonthlyPayment()*12
            let remainingDebt = getRemainingDebt(month: i*12, loan: loan)
                var previously: Float
                if i == 1 {
                    previously = loan.amount
                } else {
                    previously = getRemainingDebt(month: (i-1)*12, loan: loan)
                }
                let amortization:Float
                let interest:Float
            if remainingDebt > 0 {
                amortization = previously - remainingDebt
                interest = yearlyPayment - amortization
            } else {
                let lastYear = i-1
                let normalMonths = floor(getRemainingDebt(month: lastYear*12, loan: loan)/loan.getMonthlyPayment())
                let amortizationLastMonth = previously - getRemainingDebt(month: (lastYear*12)+Int(normalMonths), loan: loan)
                
                amortization = previously
                interest = loan.getMonthlyPayment() * normalMonths - amortizationLastMonth
            }
            let step = RepaymentPlanStep(date: date,
                                         amortization: amortization.roundedValue(),
                                         interest: interest.roundedValue(),
                                         remainingDebt: remainingDebt.roundedValue())
            steps.append(step)
            if step.remainingDebt == 0.0 {
                break
            }
        }
         */
        return steps
    }
    
    private func getRemainingDebt(month: Int, loan: AnnuityLoan)->Float{
        let m_a_rate = loan.amortizationRate/12.0
        let m_i_rate = loan.interestRate/12.0
        let remaining = loan.amount - (loan.amount * m_a_rate) * ((pow(1+m_i_rate, Float(month))-1)/m_i_rate)
        if remaining < 0 {
            return 0
        } else {
            return remaining
        }
    }
}
