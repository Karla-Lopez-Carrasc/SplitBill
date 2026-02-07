//
//  PersonCard.swift
//  SplitBill
//
//  Created by Karla Lopez on 06/02/26.
//

import SwiftUI

struct PersonCard: View {

    let personNumber: Int
    let baseAmount: Double
    let tipAmount: Double
    let totalAmount: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {

            Text("Persona \(personNumber)")
                .font(.headline)

            Text("Total a pagar")
                .font(.caption)
                .foregroundColor(.gray)

            Text("$\(String(format: "%.2f", totalAmount))")
                .font(.title3)
                .fontWeight(.bold)

            HStack {
                Text("Factura: $\(String(format: "%.2f", baseAmount))")
                Spacer()
                Text("Propina: $\(String(format: "%.2f", tipAmount))")
            }
            .font(.caption)
            .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.blue.opacity(0.08))
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

struct PersonCard_Previews: PreviewProvider {
    static var previews: some View {
        PersonCard(
            personNumber: 1,
            baseAmount: 40,
            tipAmount: 6,
            totalAmount: 46
        )
        .padding()
    }
}
