//
//  InformacionView.swift
//  MueveTec
//
//  Created by Frouta on 29/03/25.
//

import SwiftUI

struct InformacionView: View {
    
    let faqItems = InformacionViewModel()
    @Environment(\.dismiss) private var dismiss
    var color: Color = .blueFondo

    var body: some View {
        Button(action: {
            dismiss()
        }) {
            HStack{
                Image(systemName: "chevron.backward")
                    .aspectRatio(contentMode: .fit)
                    .font(.title)
                    .foregroundColor(color)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
            .padding(.top,12)
        }
        List {
            ForEach(faqItems.informacionItems) { item in
                DisclosureGroup(
                    content: {
                        Text(item.respuesta)
                            .font(.custom("Manrope-Light", size: 16))
                            .padding(.vertical, 8)
                    },
                    label: {
                        if item.numeroPregunta == 5 {
                            Text(item.pregunta)
                                .font(.custom("Manrope-Bold", size: 20))
                                .foregroundColor(Color.blueCuarto)
                        } else{
                            Text(item.pregunta)
                                .font(.custom("Manrope-Regular", size: 18))
                        }
                    }
                    
                )
                .accentColor(.blueFondo)
            }
        }
        .listStyle(.plain)
        .navigationBarBackButtonHidden(true)
        //.navigationBarItems(leading: btnBack)
    }
}

#Preview {
    InformacionView()
}
