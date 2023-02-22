//
//  EquityInvestmentTests.swift
//  immo-rechnerTests
//
//  Created by Mustafa Gercek on 23.01.23.
//

import XCTest

final class EquityInvestmentTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEquityInvestmentReturnPlan() throws {
        let testInvestment = EquityInvestment(
            startDate: Date().startOfMonth(),
            initial: 100000.0,
            monthlyContribution: 0,
            expectedReturnRatio: 0.07,
            years: 10)
        
        let expectedResult = EquityInvestmentReturnPlan(endValue: 196715.23,
                                                        receivedInterest: 96715.23,
                                                        totalContribution: 0)
        
        let result = GetEquityInvestmentReturnPlanUseCase().getReturnPlan(investment: testInvestment)
        
        XCTAssertEqual(result.endValue, expectedResult.endValue)
        XCTAssertEqual(result.receivedInterest, expectedResult.receivedInterest)
    }
    
    func testEquityInvestmentPaymentReturnPlan2() throws {
        let testInvestment2 = EquityInvestment(
            startDate: Date().startOfMonth(),
            initial: 100000,
            monthlyContribution: 500,
            expectedReturnRatio: 0.07,
            years: 10)
        let result2 = GetEquityInvestmentReturnPlanUseCase().getReturnPlan(investment: testInvestment2)
        let expectedResult2 = EquityInvestmentReturnPlan(endValue: 282757.2,
                                                         receivedInterest: 122757.19,
                                                         totalContribution: 60000)
        XCTAssertEqual(result2.endValue, expectedResult2.endValue)
        XCTAssertEqual(result2.receivedInterest, expectedResult2.receivedInterest)
        XCTAssertEqual(result2.totalContribution, expectedResult2.totalContribution)
    }
    
    func testEquityInvestmentWithYearlyPaymentReturnPlan() throws {
        let testInvestment2 = EquityInvestment(
            startDate: Date().startOfMonth(),
            initial: 100000,
            monthlyContribution: 500,
            expectedReturnRatio: 0.07,
            years: 10)
        let result2 = GetEquityInvestmentReturnPlanUseCase().getYearlyReturnSteps(investment: testInvestment2)

        XCTAssertEqual(result2.count, 10)
    }
}
