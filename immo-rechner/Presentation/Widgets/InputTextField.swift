//
//  InputTextField.swift
//  immo-rechner
//
//  Created by Mustafa Gercek on 29.01.23.
//

import SwiftUI

struct InputTextField: UIViewRepresentable {
    
    typealias UIViewType = InputUITextField
    
    let numberFormatter: NumberFormatter
    let inputUITextField: InputUITextField
    
    init(numberFormatter: NumberFormatter, valueUpdater: @escaping (Int)->(), initValue: Int?) {
        self.numberFormatter = numberFormatter
        inputUITextField = InputUITextField(formatter: numberFormatter, valueUpdater: valueUpdater, initValue: initValue)
    }
    
    func makeUIView(context: Context) -> InputUITextField {
        return inputUITextField
    }
    
    func updateUIView(_ uiView: InputUITextField, context: Context) { }
}
