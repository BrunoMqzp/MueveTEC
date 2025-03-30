//
//  ServiciosView.swift
//  MueveTec
//
//  Created by Frouta on 29/03/25.
//

import SwiftUI

struct ServiciosView: View {
    let infitem = ServicioViewModel()
    @State private var displayedText = "Informacion General"
    @State private var displayedColor = "BlueTercero"
    @State private var selectedItemName: String? = nil
    @State private var selectedColor: String? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            Text(displayedText)
                .frame(maxWidth: .infinity, alignment: .bottom)
                .font(.custom("Manrope-Regular", size: 25))
                .padding(.leading)
                .padding(.vertical)
                .background(Color(displayedColor))
                .foregroundColor(Color.white)
            
            NavigationStack {
                List(infitem.servicioItems) { item in
                    NavigationLink(
                        destination: {
                            AppRouter.destinationView(for: item)
                                .onAppear {
                                    selectedItemName = item.name
                                    selectedColor = item.Color

                                }
                                .onDisappear {
                                    selectedItemName = nil
                                    selectedColor = nil
                                }
                        },
                        label: {
                            HStack {
                                Label {
                                    Text(item.name)
                                        .font(.custom("Manrope-Light", size: 20))
                                } icon: {
                                    Image(systemName: item.imagename)
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(Color.blueFondo)
                                }
                                .alignmentGuide(.listRowSeparatorLeading) { _ in -20 }
                            }
                        }
                    )
                }
                .environment(\.defaultMinListRowHeight, 75)
                .scrollContentBackground(.hidden)
                .background(Color("BlueTercero").edgesIgnoringSafeArea(.all))
                .shadow(radius: 10)
                HStack{
                    Label{
                        Text("MueveTec Mobile v1.0")
                    } icon:{
                        Image(systemName: "info.circle")
                    }
                }
            }
            
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: displayedText)
        .onChange(of: selectedItemName) {
            displayedText = selectedItemName ?? "Informacion General"
            displayedColor = selectedColor ?? "BlueTercero"
        }

    }
}

#Preview {
    ServiciosView()
}
