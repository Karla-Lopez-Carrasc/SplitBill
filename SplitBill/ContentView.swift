//
//  ContentView.swift
//  SplitBill
//
//  Created by Karla Lopez on 06/02/26.
//

import SwiftUI

struct ContentView: View {

    let onSave: (Factura) -> Void
    @Environment(\.dismiss) private var dismiss

    @State private var totalFactura = ""
    @State private var porcentajePropina = 10
    @State private var numeroPersonas = 1

    private let opcionesPropina = [0, 10, 15, 20]

    // MARK: - Cálculos

    var totalFacturaDouble: Double {
        Double(totalFactura) ?? 0
    }

    var tipAmount: Double {
        totalFacturaDouble * Double(porcentajePropina) / 100
    }

    var totalWithTip: Double {
        totalFacturaDouble + tipAmount
    }

    var perPersonTotal: Double {
        totalWithTip / Double(numeroPersonas)
    }

    var perPersonBase: Double {
        totalFacturaDouble / Double(numeroPersonas)
    }

    var perPersonTip: Double {
        tipAmount / Double(numeroPersonas)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {

                GroupBox(label: Text("Total de la factura")) {
                    TextField("Ingresar total", text: $totalFactura)
                        .keyboardType(.decimalPad)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }

                GroupBox(label: Text("Propina")) {
                    Picker("Propina", selection: $porcentajePropina) {
                        ForEach(opcionesPropina, id: \.self) {
                            Text("\($0)%")
                        }
                    }
                    .pickerStyle(.segmented)
                }

                GroupBox(label: Text("Personas")) {
                    Stepper(value: $numeroPersonas, in: 1...10) {
                        Text("\(numeroPersonas) personas")
                    }
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text("Detalle por persona")
                        .font(.headline)

                    ForEach(0..<numeroPersonas, id: \.self) { index in
                        PersonCard(
                            personNumber: index + 1,
                            baseAmount: perPersonBase,
                            tipAmount: perPersonTip,
                            totalAmount: perPersonTotal
                        )
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Factura")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Guardar") {
                    let factura = Factura(
                        fecha: Date(),
                        total: totalWithTip,
                        personas: numeroPersonas
                    )
                    onSave(factura)
                    dismiss()
                }
                .disabled(totalFacturaDouble <= 0)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(onSave: { _ in })
    }
}
