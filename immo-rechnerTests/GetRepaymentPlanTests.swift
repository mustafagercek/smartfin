//
//  GetRepaymentPlanTests.swift
//  immo-rechnerTests
//
//  Created by Mustafa Gercek on 22.01.23.
//

import XCTest

final class GetRepaymentPlanTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRepaymentPlan() throws {
        let testLoan = AnnuityLoan(
            startDate: Date().startOfMonth(),
            amount: 100000,
            interestRate: 0.04,
            amortizationRate: 0.03,
            years: 10)
        
        let result = GetRepaymentPlanUseCase().getRepaymentPlan(loan: testLoan)

        let expectedRepaymentPlan = RepaymentPlan(
            monthlyPayment: 583.33,
            yearlyPayment: 7000.00,
            totalPayment: 70000.00,
            remainingDebt: 63187.59,
            totalInterestPayment:  33187.59,
            totalAmortizationPayment: 36812.41
        )
        
        XCTAssertEqual(expectedRepaymentPlan.monthlyPayment, result.monthlyPayment)
        XCTAssertEqual(expectedRepaymentPlan.yearlyPayment, result.yearlyPayment)
        XCTAssertEqual(expectedRepaymentPlan.totalPayment, result.totalPayment)
        XCTAssertEqual(expectedRepaymentPlan.remainingDebt, result.remainingDebt)
        XCTAssertEqual(expectedRepaymentPlan.totalInterestPayment, result.totalInterestPayment)
        XCTAssertEqual(expectedRepaymentPlan.totalAmortizationPayment, result.totalAmortizationPayment)
    }
    
    func testGetMonthlyPaymentSteps() throws {
        let testLoan = AnnuityLoan(
            startDate: Date().startOfMonth().addMonth(n: 1),
            amount: 100000,
            interestRate: 0.04,
            amortizationRate: 0.03,
            years: 10)
        
        let result = GetRepaymentPlanUseCase().getMonthlyPaymentSteps(loan: testLoan)
        
        XCTAssertEqual(120, result.count)
        XCTAssertEqual(63187.59, result.last!.remainingDebt)
        XCTAssertEqual(211.86, result.last!.interest)
        XCTAssertEqual(371.47, result.last!.amortization)
    }
    
    func testGetYearlyPaymentSteps() throws {
        let testLoan = AnnuityLoan(
            startDate: Date().startOfMonth().addMonth(n: 1),
            amount: 100000,
            interestRate: 0.04,
            amortizationRate: 0.03,
            years: 10)
        
        let result = GetRepaymentPlanUseCase().getYearlyPaymentSteps(loan: testLoan)
        
        XCTAssertEqual(10, result.count)
        XCTAssertEqual(63187.59, result.last!.remainingDebt)
        XCTAssertEqual(2622.92, result.last!.interest)
        XCTAssertEqual(4377.08, result.last!.amortization)
    }
}
