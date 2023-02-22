//
//  Rent.swift
//  immo-rechner
//
//  Created by Mustafa Gercek on 23.01.23.
//

import Foundation

struct Rent {
    let years: Int
    let baseRent: Float //Nettokaltmiete
    let servicesRent: Float //Nebenkosten
    let increaseRate: Float? //Mieterhöhung
}
