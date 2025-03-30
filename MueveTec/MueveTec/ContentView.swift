//
//  ContentView.swift
//  MueveTec
//
//  Created by Alumno on 28/03/25.
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
                Text("TRES")
            }
        }
    }
}

#Preview {
    ContentView()
}
