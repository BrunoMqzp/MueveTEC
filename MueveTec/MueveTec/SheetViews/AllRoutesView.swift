import SwiftUI

struct AllRoutesView: View {
    @Binding var ruta: String

    var body: some View {
        VStack {
            if(ruta != ""){
                Text("\(ruta)")
                    .font(.largeTitle)
                    .bold()
            }else{
                Text("Todas las rutas")
                    .font(.largeTitle)
                    .bold()
            }
            HStack {
                Spacer()
                Button {
                    ruta = "Hospitales y Escuelas"
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(width: 150.0, height: 150.0)
                            .foregroundStyle(Color(hue: 1.0, saturation: 0.887, brightness: 0.663))
                            .cornerRadius(20.0)
                        VStack {
                            Image(systemName: "cross.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundStyle(.white)
                            Text("Hospitales y Escuelas")
                                .font(.title2)
                                .foregroundStyle(.white)
                                .bold()
                        }
                        .frame(width: 150.0, height: 150.0)
                    }
                }
                Spacer()
                Button {
                    ruta = "Garza Sada"
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(width: 150.0, height: 150.0)
                            .foregroundStyle(Color(hue: 0.637, saturation: 0.906, brightness: 0.429))
                            .cornerRadius(20.0)
                        VStack {
                            Image(systemName: "person.bust.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundStyle(.white)
                            Text("Garza Sada")
                                .font(.title2)
                                .foregroundStyle(.white)
                                .bold()
                        }
                    }
                }
                Spacer()
            }

            HStack {
                Spacer()
                Button {
                    ruta = "Revolución"
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(width: 150.0, height: 150.0)
                            .foregroundStyle(Color(hue: 0.095, saturation: 0.808, brightness: 0.956))
                            .cornerRadius(20.0)
                        VStack {
                            Image(systemName: "building.2.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundStyle(.white)
                            Text("Revolución")
                                .font(.title2)
                                .foregroundStyle(.white)
                                .bold()
                        }
                        .frame(width: 150.0, height: 150.0)
                    }
                }
                Spacer()
                Button {
                    ruta = "Valle Alto"
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(width: 150.0, height: 150.0)
                            .foregroundStyle(Color(hue: 1.0, saturation: 1.0, brightness: 0.46))
                            .cornerRadius(20.0)
                        VStack {
                            Image(systemName: "mountain.2.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundStyle(.white)
                            Text("Valle Alto")
                                .font(.title2)
                                .foregroundStyle(.white)
                                .bold()
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    @State var ruta = ""
    AllRoutesView(ruta: $ruta)
}
