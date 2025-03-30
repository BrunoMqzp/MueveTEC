//
//  CalendarioViewModel.swift
//  MueveTec
//
//  Created by Frouta on 30/03/25.
//

import SwiftUI

class CalendarioViewModel: ObservableObject{
    let CalendarioArmado: [CalendarioModel] = [
        CalendarioModel(Periodo: "FEBRERO-JUNIO", Disponibilidad: true),
        CalendarioModel(Periodo: "VERANO", Disponibilidad: false),
        CalendarioModel(Periodo: "AGOSTO-DICIEMBRE", Disponibilidad: true),
        CalendarioModel(Periodo: "INVIERNO", Disponibilidad: false)
    ]
    
}
