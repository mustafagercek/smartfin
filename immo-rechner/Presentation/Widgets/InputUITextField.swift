//
//  InputUITextField.swift
//  immo-rechner
//
//  Created by Mustafa Gercek on 29.01.23.
//

import UIKit
import SwiftUI

class InputUITextField: UITextField {
        
    private var value: Int
    private var valueUpdater: (Int)->()
    private let formatter: NumberFormatter
    
    init(formatter: NumberFormatter, valueUpdater: @escaping (Int)->(), initValue:Int?) {
        self.formatter = formatter
        self.valueUpdater = valueUpdater
        value = initValue ?? 0
        super.init(frame: .zero)
        if value > 0 {
            let initValue = Decimal(value) * decimalMultiplier
            text = formatter.string(for: initValue)
        }
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        addTarget(self, action: #selector(resetSelection), for: .allTouchEvents)
        keyboardType = .numberPad
        textAlignment = .right
        sendActions(for: .editingChanged)
    }
    
    override func deleteBackward() {
        text = textValue.digits.dropLast().string
        sendActions(for: .editingChanged)
    }
    
    private func setupViews() {
        tintColor = .clear
        font = .systemFont(ofSize: 20, weight: .regular)
    }
    
    @objc private func editingChanged() {
        if Int(textValue.digits)?.string.count ?? 0 <= maxDigits {
            text = formatter.string(for: decimal) ?? ""
            resetSelection()
            let newIntValue = (decimal / decimalMultiplier as NSDecimalNumber).intValue
            value = newIntValue
            valueUpdater(newIntValue)
            //value = newIntValue
        } else {
            let oldValue = Decimal(value) * decimalMultiplier
            text = formatter.string(for: oldValue)
        }
    }
    
    @objc private func resetSelection() {
        selectedTextRange = textRange(from: endOfDocument, to: endOfDocument)
    }
    
    private var textValue: String {
        return text ?? ""
    }
    
    private var doubleValue: Double {
        return (decimal as NSDecimalNumber).doubleValue
    }
    
    private var decimal: Decimal {
        return textValue.toDecimal * decimalMultiplier
    }
    
    private var previousDecimal: Decimal {
        return Decimal(value) * decimalMultiplier
    }
    
    private var decimalMultiplier: Decimal {
        // Entry 1
        // currency
        // with fraction (0) --> 1 €
        // with fraction (2) --> 0,01 €
        // percentage
        // with fraction (2) double 0,001 --> 0,01 %
        if formatter.numberStyle == .percent {
            return 1/pow(10,formatter.maximumFractionDigits+2)
        } else {
            return 1/pow(10,formatter.maximumFractionDigits)
        }
    }
    
    private var maxDigits: Int {
        return formatter.maximumIntegerDigits + formatter.maximumFractionDigits
    }
    
    private func formatToString(from decimal: Decimal) -> String {
        return formatter.string(for: decimal) ?? ""
    }
}

extension String {
    var toDecimal: Decimal { Decimal(string: digits) ?? 0 }
}

extension StringProtocol where Self: RangeReplaceableCollection {
    var digits: Self { filter (\.isWholeNumber) }
}

extension String {
    var number: Int { Int (digits) ?? 0 }
}

extension LosslessStringConvertible {
    var string: String { .init(self) }
}

