//
//  AjustesView.swift
//  MueveTec
//
//  Created by Frouta on 29/03/25.
//

import SwiftUI

struct AjustesView: View {
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
        NavigationStack {
            Form {
                Section("Tema") {
                    DarkModeToggle()
                }
            }
        }
            .navigationBarBackButtonHidden(true)
    }
}
#Preview {
    AjustesView()
}
