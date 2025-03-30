//
//  InformacionModel.swift
//  MueveTec
//
//  Created by Frouta on 29/03/25.
//
import SwiftUI

struct InformacionModel: Identifiable{

    let id = UUID()
    let numeroPregunta: Int
    var pregunta: String
    var respuesta: String
}
