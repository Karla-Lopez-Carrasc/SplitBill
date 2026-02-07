//
//  FacturaListView.swift
//  SplitBill
//
//  Created by Karla Lopez on 06/02/26.
//

import SwiftUI

struct FacturaListView: View {

    @State private var facturas: [Factura] = []
    @State private var mostrarNuevaFactura = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(facturas) { factura in
                    VStack(alignment: .leading) {
                        Text(factura.fecha, style: .date)
                            .font(.headline)

                        HStack {
                            Text("Total: $\(String(format: "%.2f", factura.total))")
                            Spacer()
                            Text("Personas: \(factura.personas)")
                        }
                        .font(.caption)
                        .foregroundColor(.secondary)
                    }
                }
                .onDelete(perform: eliminarFactura)
            }
            .navigationTitle("Facturas")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        mostrarNuevaFactura = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationDestination(isPresented: $mostrarNuevaFactura) {
                ContentView { nuevaFactura in
                    facturas.append(nuevaFactura)
                }
            }
        }
    }

    private func eliminarFactura(at offsets: IndexSet) {
        facturas.remove(atOffsets: offsets)
    }
}

struct FacturaListView_Previews: PreviewProvider {
    static var previews: some View {
        FacturaListView()
    }
}



#Preview {
    FacturaListView()
}
