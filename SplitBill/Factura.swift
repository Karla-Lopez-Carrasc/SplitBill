//
//  Factura.swift
//  SplitBill
//
//  Created by Karla Lopez on 06/02/26.
//

import Foundation

struct Factura: Identifiable {
    let id = UUID()
    let fecha: Date
    let total: Double
    let personas: Int
}
