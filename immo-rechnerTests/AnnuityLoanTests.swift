//
//  AnnuityLoanTests.swift
//  immo-rechnerTests
//
//  Created by Mustafa Gercek on 22.01.23.
//

import XCTest

final class AnnuityLoanTests: XCTestCase {
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAnnuity() throws {
        let testLoan = AnnuityLoan(
            startDate: Date(),
            amount: 200000,
            interestRate: 0.035,
            amortizationRate: 0.0346,
            years: 10)
        
        let expectedResult:Float = 1160
        
        XCTAssertEqual(testLoan.getMonthlyPayment(), expectedResult)
    }
}
