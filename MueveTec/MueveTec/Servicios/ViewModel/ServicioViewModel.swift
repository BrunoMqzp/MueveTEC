//
//  ServicioViewModel.swift
//  MueveTec
//
//  Created by Frouta on 29/03/25.
//

import Foundation
import SwiftUI

class ServicioViewModel: ObservableObject {
    let servicioItems: [ServicioModel] = [
        ServicioModel(name: "Calendario", imagename: "calendar", destino: .calendario, Color:"AmarilloPrimero"),
        ServicioModel(name: "Informacion", imagename: "info.circle", destino: .informacion, Color:"AmarilloPrimero"),
        ServicioModel(name: "Ajustes", imagename: "gear", destino: .ajustes, Color:"AmarilloPrimero")
    ]
}

enum AppRouter {
    @ViewBuilder
    static func destinationView(for item: ServicioModel) -> some View {
        switch item.destino {
        case .informacion:
            InformacionView()
        case .ajustes:
            AjustesView()
        case .calendario:
            CalendarioView()
        }
    }
}
