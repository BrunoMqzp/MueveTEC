//
//  CalendarioView.swift
//  MueveTec
//
//  Created by Frouta on 29/03/25.
//

import SwiftUI

struct CalendarioView: View{
    var CMV = CalendarioViewModel()
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
        ScrollView{
            ForEach([2025, 2026], id: \.self) { year in
                ForEach(CMV.CalendarioArmado){item in
                    VStack{
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(Color(.secondarySystemBackground))
                            .overlay(
                                VStack(spacing: 16) {
                                    if item.Disponibilidad == true {
                                        Text("Disponible")
                                            .font(.custom("Manrope-Bold", size: 15))
                                            .foregroundColor(Color.green)
                                    }
                                    if item.Disponibilidad == false {
                                        Text("Limitado")
                                            .font(.custom("Manrope-Bold", size: 15))
                                            .foregroundColor(Color.yellow)
                                    }
                                    Text("\(item.Periodo) \(String(year))")
                                        .font(.custom("Manrope-Light", size: 20))
                                }
                                    .padding(20)
                            )
                            .frame(width: 300, height: 200)
                            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 4)
                            .padding(.horizontal, 20)
                    }
                }
            }
        }
        .frame(maxHeight:.infinity, alignment: .top)
        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    CalendarioView()
}
