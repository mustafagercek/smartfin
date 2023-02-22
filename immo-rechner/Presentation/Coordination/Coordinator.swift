//
//  Coordinator.swift
//  immo-rechner
//
//  Created by Mustafa Gercek on 05.02.23.
//

import Foundation
import SwiftUI

class Coordinator: ObservableObject {
    @Published var path = NavigationPath()
    
    func gotoHomePage() {
        path.removeLast(path.count)
    }
    
    func gotoRepaymentPlan(loan: AnnuityLoan) {
        path.append(Destination.loanRepaymentPlan(loan))
    }
}
