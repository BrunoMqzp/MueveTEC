//
//  ServicioModel.swift
//  MueveTec
//
//  Created by Frouta on 29/03/25.
//

import SwiftUI

struct ServicioModel: Identifiable, Equatable{
    let id = UUID()
    var name: String
    var imagename: String
    let destino: ServicioType
    var Color: String
}

enum ServicioType: String, Identifiable {
    case informacion
    case ajustes
    case calendario
    
    var id: String { self.rawValue }
}
