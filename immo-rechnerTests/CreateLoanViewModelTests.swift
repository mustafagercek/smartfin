//
//  CreateLoanViewModelTests.swift
//  immo-rechnerTests
//
//  Created by Mustafa Gercek on 30.01.23.
//

import XCTest
@testable import immo_rechner

class CreateLoanViewModelTests: XCTestCase {
    var viewModel: CreateLoanViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = CreateLoanViewModel()
    }
    
    func testAnnuityLoanCreation() {
        let date = Date()
        // when
        viewModel.loanAmount = 100000
        viewModel.interest = 30
        viewModel.amortization = 30
        viewModel.years = 10
        
        // then
        let expectedResult = AnnuityLoan(startDate: date, amount: 100000, interestRate: 0.003, amortizationRate: 0.003, years: 10)
        
        let result = viewModel.createAnnuityLoan()
        
        XCTAssertEqual(result.amount, expectedResult.amount)
        XCTAssertEqual(result.interestRate, expectedResult.interestRate)
        XCTAssertEqual(result.years, expectedResult.years)
        XCTAssertEqual(result.amortizationRate, expectedResult.amortizationRate)
    }
}

