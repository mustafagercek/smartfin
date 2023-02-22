//
//  Destination.swift
//  immo-rechner
//
//  Created by Mustafa Gercek on 05.02.23.
//

import Foundation

enum Destination: Hashable,Identifiable {
    case loanRepaymentPlan(AnnuityLoan)
    
    var id: String {
        switch self {
        case .loanRepaymentPlan:
            return "loanRepaymentPlan"
        }
    }
    
    static func == (lhs: Destination, rhs: Destination) -> Bool {
        return lhs.id == rhs.id
    }
}
