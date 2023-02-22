//
//  FormulaHelper.swift
//  immo-rechner
//
//  Created by Mustafa Gercek on 25.01.23.
//

import Foundation
 
class FormulaManager{
    
    static let shared = FormulaManager()
    
    // Anfang
    func calc_endwertfaktor_vorschuessig(q:Float,n:Float)->Float{
        return q * ((pow(q,n)-1)/(q-1))
    }
    
    // Ende des Jahres
    func calc_endwertfaktor_nachschuessig(q:Float,n:Float)->Float{
        return (pow(q,n)-1)/(q-1)
    }
}
