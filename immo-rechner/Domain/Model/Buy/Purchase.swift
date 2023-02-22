//
//  PurchaseInformation.swift
//  immo-rechner
//
//  Created by Mustafa Gercek on 22.01.23.
//

import Foundation

struct Purchase {
    let price: Float
    let additionalCost: AdditionalCostRatios
    let investment: Float
    let ownEquity: Float
    let loan: AnnuityLoan
}
