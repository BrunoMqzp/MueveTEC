//
//  ContentView.swift
//  MueveTec
//
//  Created by Frouta on 28/03/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            Tab("Mapa", systemImage: "sailboat") {
                Text("UNO")
            }
            
            Tab("Rutas", systemImage: "wind") {
                Text("DOS")
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
