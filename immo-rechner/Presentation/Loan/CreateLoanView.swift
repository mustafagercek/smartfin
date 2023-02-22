//
//  CreateAnnuityLoanView.swift
//  immo-rechner
//
//  Created by Mustafa Gercek on 26.01.23.
//

import SwiftUI
import Combine

struct CreateLoanView: View {

    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel: CreateLoanViewModel = CreateLoanViewModel()
        
    var body: some View {
        VStack {
            Text("Basisdaten zum Darlehen")
                .font(.caption)
                .padding(EdgeInsets(top: 16, leading: 8, bottom: 0, trailing: 8))
            
            InputFieldView(placeholder: "Darlehensbetrag",
                           formatter: currencyFormatter,
                           initValue: 100000,
                           valueUpdater: {new in viewModel.loanAmount = new})
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
            
             HStack {
             InputFieldView(placeholder: "Sollzins (p.a.)",
                            formatter: percentageFormatter,
                            initValue: 420,
                            valueUpdater: {new in viewModel.interest = new})

             InputFieldView(placeholder: "Tilgung (p.a)",
                            formatter: percentageFormatter,
                            initValue: 200,
                            valueUpdater: {new in viewModel.amortization = new})
             }.padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
             
             
             HStack {
             InputFieldView(placeholder: "Jahre",
                            formatter: naturalFormatter,
                            initValue: 10,
                            valueUpdater: {new in viewModel.years = new})

             InputFieldView(placeholder: "Monate",
                            formatter: naturalFormatter,
                            valueUpdater: {new in viewModel.months = new})
             }.padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
             
            
            Button {
                coordinator.gotoRepaymentPlan(loan: viewModel.createAnnuityLoan())
            } label: {
                Text("Tilgungsplan berechnen")
                    .bold()
                    .textCase(.uppercase)
                    .frame(maxWidth: .infinity)
                    .frame(height: 30)
            }
            .disabled(!viewModel.isButtonEnabled)
            .buttonStyle(.borderedProminent)
            .padding()
            
            Spacer()
            
        }
        .background{Color.BackgroundColor.ignoresSafeArea()}
        .navigationBarTitle("Tilgungsrechner", displayMode: .inline)
        .toolbarBackground(Color.PrimaryColor, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
    
    private var currencyFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .currency
        f.locale = Locale(identifier: "de_DE")
        f.maximumFractionDigits = 0
        f.maximumIntegerDigits = 10
        return f
    }()
    
    private var percentageFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .percent
        f.minimumIntegerDigits = 1
        f.maximumIntegerDigits = 2
        f.maximumFractionDigits = 2
        f.minimumFractionDigits = 2
        return f
    }()
    
    private var naturalFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.minimumIntegerDigits = 1
        f.maximumIntegerDigits = 3
        f.maximumFractionDigits = 0
        return f
    }()
}


struct CreateAnnuityLoanView_Previews: PreviewProvider {
    static var previews: some View {
        CreateLoanView()
    }
}


struct InputFieldView: View {
    
    var placeholder: String
    var formatter: NumberFormatter
    var initValue: Int?
    var valueUpdater: (Int) -> ()
    
    var body: some View {
        HStack {
            Text(placeholder)
                .font(.system(size: 16))
                .foregroundColor(.gray)
                .frame(minWidth: 0, maxWidth: .infinity,alignment: .leading)
                .padding(.leading, 8)
            
            InputTextField(numberFormatter: formatter, valueUpdater: valueUpdater, initValue: initValue)
                .id("\(placeholder)")
                .padding(.trailing, 8)
                .frame(minWidth: 0, maxWidth: .infinity,alignment: .leading)
                .frame(height: 50)
        }
        .background{Color.white}
        .cornerRadius(10)
    }
}
