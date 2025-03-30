//
//  InformacionViewModel.swift
//  MueveTec
//
//  Created by Frouta on 29/03/25.
//

import Foundation
import SwiftUI

class InformacionViewModel: ObservableObject {
    let informacionItems: [InformacionModel] = [
        InformacionModel(numeroPregunta: 1, pregunta: "¿Quien puede usar el servicio?", respuesta: "Estudiantes que estén inscritos en el semestre en curso."),
        InformacionModel(numeroPregunta: 2, pregunta: "¿Tiene Costo?", respuesta: "El servicio es gratuito para estudiantes, profesores y colaboradores del Tecnológico de Monterrey."),
        InformacionModel(numeroPregunta: 3,
            pregunta: "¿Las rutas nocturnas tienen paradas especificas?",
            respuesta: """
            El objetivo del servicio de transporte nocturno es acercar a los usuarios a sus viviendas en las zonas delimitadas. Por esta razón, el recorrido de las unidades no cuentan con paradas específicas.
            
                 Los operadores (choferes) de las unidades en turno, tendrán las siguientes consideraciones:
            
                 -Dependiendo de la cantidad de usuarios ocupando un asiento, del recorrido establecido de la tabla de horarios, se considerará:
                 -Dejar a los usuarios en la puerta de su vivienda; aplica cuando la cantidad de usuarios sean pocos y se logre el regreso de la unidad a tiempo para su siguiente recorrido.
                 -Durante los horarios de madrugada de poco o nulo movimiento en la vía pública, si se toma en consideración dejar al usuario en su vivienda.
                 -En horarios con actividad en la vía pública o con iluminación natural (dependiendo del horario y fecha), y que la cantidad de usuarios sea considerable, los usuarios tendrán que acatar el descenso sobre calles y avenidas principales, sin la posibilidad de llegar hasta su vivienda.
            """),
        InformacionModel(numeroPregunta: 4,
            pregunta: "¿Puedo Abordar el servicio Fuera del Campus?",
            respuesta: """
                Solamente está permitido en el servicio diurno:
                - Ruta Garza Sada
                - Ruta Hospitales y Escuelas
                - Ruta Revolución
                - Ruta Valle Alto
                - Directo San José - Campus Monterrey
                
                El servicio nocturno, por lineamientos de seguridad, no es posible.
                """
        ),
        InformacionModel(numeroPregunta: 5,
            pregunta: "Plan de contingencia CircuitoTec",
            respuesta: """
                ¿Qué debo hacer en caso de retardo de la unidad, falla mecánica, accidente vial o contingencia meteorológica?
                -Comunícate al teléfono de atención de Grupo SENDA, CircuitoTec +51 81 1266 3914 con Roberto González, Coordinador de Rutas de Servicio de Grupo SENDA.
                """
        )
    
    ]
}
