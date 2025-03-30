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
            Tab("Mapa", systemImage: "map") {
                MapaView()
            }
            Tab("Servicios", systemImage: "house.fill"){
                ServiciosView()
            }
        }
    }
}

#Preview {
    ContentView()
}
