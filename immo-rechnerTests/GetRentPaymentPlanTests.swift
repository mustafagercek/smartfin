//
//  GetRentPaymentPlanTests.swift
//  immo-rechnerTests
//
//  Created by Mustafa Gercek on 25.01.23.
//

import XCTest

final class GetRentPaymentPlanTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let rent = Rent(years: 10, baseRent: 850, servicesRent: 200, increaseRate: 0.01)
        let rentPaymentPlan = GetRentPaymentPlanUseCase().getRentPaymentPlan(rent: rent)
        XCTAssertEqual(106714.55, rentPaymentPlan.totalRentPayment)
        XCTAssertEqual(929.63, rentPaymentPlan.futureMonthlyRent)
        XCTAssertEqual(11155.59, rentPaymentPlan.futureYearlyRent)
    }
}
