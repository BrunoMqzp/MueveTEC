//
//  ContentView.swift
//  MueveTec
//
//  Created by Ranferi on 28/03/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            Tab("Mapa", systemImage: "sailboat") {
                MapaView()
            }
            
            Tab("Rutas", systemImage: "wind") {
                RevolucionView()
            }
            
            Tab("Servicios", systemImage: "house.fill"){
                Text("TRES")
            }
        }
    }
}

#Preview {
    ContentView()
}
