//
//  EstacioView.swift
//  MueveTec
//
//  Created by J Lugo on 30/03/25.
//

import SwiftUI

struct EstacionView: View {
    @State var estacion: BusStop
    @State private var ruta: String = ""
    @State private var currentRoute: [BusRoute] = []

    var busRoutes: [BusRoute]

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("\(estacion.name)")
                    .font(.largeTitle)
                    .bold()
                Spacer()
            }

            // Mostrar la hora de llegada
            Text("Hora de llegada: \(calcularHoraLlegada())")
                .font(.title)

            // Mostrar la ruta correspondiente
            if let routeName = obtenerRuta() {
                Text("Ruta: \(routeName)")
                    .font(.title2)
            }

            HStack {
                Spacer()
                Text("Resto de la ruta")
                Spacer()
            }

            // Mostrar las paradas de la ruta
            List(currentRoute.first?.stops ?? []) { parada in
                HStack {
                    Image(systemName: "mappin")
                    Text("\(parada.name)")
                    Spacer()
                    Text("\(parada.minutes)")
                }
            }
            .listStyle(.plain)
        }
        .onAppear {
            // Extraemos la ruta cuando la vista aparece
            ruta = obtenerRuta() ?? "Ruta no disponible"
            fetchSingleRoute(nombre: ruta)
        }
    }

    func fetchSingleRoute(nombre: String) {
        // Simulación de llamada a la API (puedes reemplazar esto con una llamada real)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if let route = busRoutes.first(where: { $0.name == nombre }) {
                self.currentRoute = [route]
            }
        }
    }

    func calcularHoraLlegada() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"

        let now = Date()
        let calendar = Calendar.current
        let currentHour = calendar.component(.hour, from: now)
        let currentMinute = calendar.component(.minute, from: now)

        let currentTotalMinutes = (currentHour * 60) + currentMinute
        let startOfDayTotalMinutes = (7 * 60) // 7:00 AM
        let endOfDayTotalMinutes = (19 * 60) // 7:00 PM

        let timeComponents = estacion.minutes.split(separator: ":").compactMap { Int($0) }
        guard timeComponents.count == 2 else { return "Error en formato de minutos" }
        let minutesToAdd = timeComponents[1]

        var baseDate: Date
        if currentTotalMinutes >= startOfDayTotalMinutes && currentTotalMinutes < endOfDayTotalMinutes {
            let adjustedHour = calendar.date(bySettingHour: currentHour, minute: 0, second: 0, of: now) ?? now
            baseDate = adjustedHour
        } else {
            var components = DateComponents()
            components.hour = 7
            components.minute = 0
            baseDate = calendar.date(from: components) ?? now
        }

        if let nuevaHora = calendar.date(byAdding: .minute, value: minutesToAdd, to: baseDate) {
            return formatter.string(from: nuevaHora)
        } else {
            return "Error al calcular"
        }
    }

    // Función para obtener la ruta correspondiente a esta estación
    func obtenerRuta() -> String? {
        for route in busRoutes {
            if route.stops.contains(where: { $0.id == estacion.id }) {
                return route.name
            }
        }
        return nil
    }

    func obtenerRestoParadas(name: String) -> [BusStop] {
        for route in busRoutes {
            if route.name == name {
                return route.stops
            }
        }
        return []
    }
}




#Preview {
    ContentView()
}


/*
#Preview {
    EstacionView(estacion: BusStop(id: 1, name: "Estación 1"))
}
*/
