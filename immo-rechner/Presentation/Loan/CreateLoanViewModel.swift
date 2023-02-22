//
//  CreateLoanViewModel.swift
//  immo-rechner
//
//  Created by Mustafa Gercek on 29.01.23.
//

import Foundation
import Combine
import SwiftUI

class CreateLoanViewModel: ObservableObject {
    @Published
    var isButtonEnabled: Bool = false
    
    var loanAmount: Int = 0 {
        didSet {
            DispatchQueue.main.async{
                self.isButtonEnabled = self.isEntrySufficient()
            }
        }
    }
    
    var interest:Int = 0 {
        didSet {
            DispatchQueue.main.async{
                self.isButtonEnabled = self.isEntrySufficient()
            }
        }
    }
    
    var amortization:Int = 0 {
        didSet {
            DispatchQueue.main.async{
                self.isButtonEnabled = self.isEntrySufficient()
            }
        }
    }
    
    var years:Int = 0 {
        didSet {
            DispatchQueue.main.async{
                self.isButtonEnabled = self.isEntrySufficient()
            }
        }
    }
    
    var months:Int = 0 {
        didSet {
            DispatchQueue.main.async{
                self.isButtonEnabled = self.isEntrySufficient()
            }
        }
    }
    
    func createAnnuityLoan()->AnnuityLoan{
        return AnnuityLoan(startDate: Date().startOfMonth(), amount: Float(loanAmount), interestRate: Float(interest)/10000, amortizationRate: Float(amortization)/10000, years: years)
    }
    
    private func isEntrySufficient()->Bool {
        return loanAmount > 0 && years > 0 && interest > 0
    }
}
