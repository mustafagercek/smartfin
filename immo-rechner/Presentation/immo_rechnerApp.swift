//
//  immo_rechnerApp.swift
//  immo-rechner
//
//  Created by Mustafa Gercek on 22.01.23.
//

import SwiftUI

@main
struct immo_rechnerApp: App {
    let persistenceController = PersistenceController.shared
    @ObservedObject var coordinator = Coordinator()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                CreateLoanView()
                    .navigationDestination(for: Destination.self) { destination in
                        switch destination {
                        case .loanRepaymentPlan(let loan): LoanRepaymentPlanView(annuityLoan: loan)
                        }
                    }
            }
            .environmentObject(coordinator)
        }
    }
}
