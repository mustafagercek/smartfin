//
//  LoanRepaymentPlan.swift
//  immo-rechner
//
//  Created by Mustafa Gercek on 30.01.23.
//

import SwiftUI

struct LoanRepaymentPlanView: View {
    
    var annuityLoan: AnnuityLoan
    let useCase = GetRepaymentPlanUseCase()
    
    @State
    var selectedStepMode:Int = 0

    
    var body: some View {
        let repaymentPlan = useCase.getRepaymentPlan(loan: annuityLoan)
        let monthlySteps = useCase.getMonthlyPaymentSteps(loan: annuityLoan)
        let yearlySteps = useCase.getYearlyPaymentSteps(loan: annuityLoan)

        ScrollView(.vertical){
            VStack{
                VStack(spacing: 0) {
                    Text("Zusammenfassung")
                        .font(.system(size: 20))
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.AccentColor)
                        .padding(.bottom, 2)
                    
                    Text("Während der Sollzinsbindung von \(annuityLoan.years) Jahren")
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 8)
                    
                    HStack {
                        Text("Monatliche Rate")
                            .font(.system(size: 14))
                            .frame(minWidth: 0, maxWidth: .infinity,alignment: .leading)
                        
                        Text(repaymentPlan.monthlyPayment.toCurrency())
                            .font(.system(size: 16))
                            .bold()
                    }
                    .padding(.bottom, 4)
                    
                    
                    HStack {
                        Text("Restschuld")
                            .font(.system(size: 14))
                            .frame(minWidth: 0, maxWidth: .infinity,alignment: .leading)
                        
                        Text(repaymentPlan.remainingDebt.toCurrency())
                            .font(.system(size: 16))
                            .bold()
                    }
                    .padding(.bottom, 4)
                    
                    HStack {
                        Text("Ratenzahlungen")
                            .font(.system(size: 14))
                            .frame(minWidth: 0, maxWidth: .infinity,alignment: .leading)
                        
                        Text(repaymentPlan.totalPayment.toCurrency())
                            .font(.system(size: 16))
                            .bold()
                    }
                    .padding(.bottom, 4)
                    
                    HStack {
                        Text("Tilgung")
                            .font(.system(size: 14))
                            .frame(minWidth: 0, maxWidth: .infinity,alignment: .leading)
                        
                        Text(repaymentPlan.totalAmortizationPayment.toCurrency())
                            .font(.system(size: 16))
                            .bold()
                    }
                    .padding(.bottom, 4)
                    
                    HStack {
                        Text("Zinsen")
                            .font(.system(size: 14))
                            .frame(minWidth: 0, maxWidth: .infinity,alignment: .leading)
                        
                        Text(repaymentPlan.totalInterestPayment.toCurrency())
                            .font(.system(size: 16))
                            .bold()
                    }
                    .padding(.bottom, 4)
                }
                .padding()
                .background(Color.PrimaryColor.cornerRadius(10))
                .padding(EdgeInsets(top: 16, leading: 16, bottom: 8, trailing: 16))
                
                Text("Tilgungsplan im Detail")
                    .font(.caption)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))

                Picker("Tilgungsplan Anzeigemodus", selection: $selectedStepMode) {
                       Text("Jährlich").tag(0)
                       Text("Monatlich").tag(1)
                   }
                .pickerStyle(.segmented)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))

                VStack(spacing: 0) {
                    GeometryReader { geometry in
                        HStack(spacing: 0) {
                            Text("Datum")
                                .frame(width: 0.175 * geometry.size.width,
                                       height: 30)
                                .font(.system(size: 14.0))
                                .bold()
                            Text("Zinsanteil")
                                .frame(width: 0.25 * geometry.size.width,
                                       height: 30)
                                .font(.system(size: 14.0))
                                .bold()
                            
                            Text("Tilgung")
                                .frame(width: 0.25 * geometry.size.width,
                                       height: 30)
                                .font(.system(size: 14.0))
                                .bold()
                            
                            Text("Restschuld")
                                .frame(width: 0.325 * geometry.size.width,
                                       height: 30)
                                .font(.system(size: 14.0))
                                .bold()
                        }
                    }
                    .frame(height: 30)
                    
                    if selectedStepMode == 0 {
                        RepaymentPlanStepList(steps: yearlySteps)
                    } else {
                        RepaymentPlanStepList(steps: monthlySteps)
                    }
                }
                .background(Color.PrimaryColor)
                .cornerRadius(10)
                .padding(.leading, 16)
                .padding(.trailing, 16)

            }
        }
        .background{Color.BackgroundColor.ignoresSafeArea()}
        .navigationBarTitle("Tilgungsplan", displayMode: .inline)
        .toolbarBackground(Color.PrimaryColor, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

struct RepaymentPlanStepList: View {
    
    var steps: [RepaymentPlanStep]
    
    var body: some View {
        ForEach(Array(steps.enumerated()), id: \.offset) { index, step in
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    Text(step.date.MM_YY())
                        .frame(width: 0.175 * geometry.size.width,
                               height: 25)
                        .font(.system(size: 14.0))
                    Text(step.interest.toCurrency())
                        .frame(width: 0.25 * geometry.size.width,
                               height: 25)
                        .font(.system(size: 14.0))
                    Text(step.amortization.toCurrency())
                        .frame(width: 0.25 * geometry.size.width,
                               height: 25)
                        .font(.system(size: 14.0))
                    Text(step.remainingDebt.toCurrency())
                        .frame(width: 0.325 * geometry.size.width,
                               height: 25)
                        .font(.system(size: 14.0))
                }
            }
            .frame(height: 25, alignment: .center)
            .background{
                if index % 2 == 0  {
                    Color.white
                } else {
                    Color(.systemGray5)
                }
            }
        }

    }
}


struct LoanRepaymentPlan_Previews: PreviewProvider {
    
    static let annuityLoan = AnnuityLoan(startDate: Date(), amount: 100000, interestRate: 0.02, amortizationRate: 0.02, years: 10)
    
    static var previews: some View {
        NavigationStack {
            LoanRepaymentPlanView(annuityLoan: annuityLoan)
        }
    }
}
