import SwiftUI
import MapKit

extension MKCoordinateSpan: Equatable {
    public static func == (lhs: MKCoordinateSpan, rhs: MKCoordinateSpan) -> Bool {
        lhs.latitudeDelta == rhs.latitudeDelta && lhs.longitudeDelta == rhs.longitudeDelta
    }
}

struct MapaView: View {
    @State private var ruta: String = ""
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 25.651426, longitude: -100.289570), // Tec de Monterrey
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01) // Default zoom
    )
    
    @State private var busRoutes: [BusRoute] = []
    @State private var showLabels: Bool = true
    @State private var showMore: Bool = false
    @State private var selectedStop: BusStop? // 🔹 Guarda la estación seleccionada

    let routeColors: [Color] = [.red, .brown, .orange, .blue]

    @State private var showSheet: Bool = true

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: busStops()) { stop in
            MapAnnotation(coordinate: stop.coordinate) {
                Button(action: {
                    selectedStop = stop // ✅ Guarda la estación seleccionada
                    showMore = true
                    print("🚏 Estación seleccionada: \(stop.name), Coordenadas: \(stop.coordinate)")
                }) {
                    VStack {
                        if let route = busRoutes.first(where: { $0.stops.contains(where: { $0.id == stop.id }) }),
                           let index = busRoutes.firstIndex(where: { $0.id == route.id }) {
                            let color = routeColors[index % routeColors.count]
                            Image(systemName: "bus")
                                .foregroundColor(color)
                                .font(.title)
                        }
                        
                        Text(stop.name)
                            .font(.caption)
                            .padding(5)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(5)
                            .opacity(showLabels ? 1 : 0) // Smooth fade
                    }
                }
            }
        }
        .onAppear {
            fetchBusRoutes()
            showSheet = true
        }
        .onChange(of: region.span) { newSpan in
            withAnimation(.easeInOut(duration: 0.3)) {
                showLabels = newSpan.latitudeDelta < 0.02 // Toggle label visibility
            }
        }
        .onChange(of: ruta) { newRuta in
            fetchSingleRoute(nombre: newRuta)
        }
        .onDisappear {
            showSheet = false
        }
        .sheet(isPresented: $showSheet) {
            GeometryReader { geometry in
                VStack(spacing: 10) {
                    if geometry.size.height > 120 {
                        if(showMore == true){
                            EstacionView(estacion: selectedStop!, busRoutes: busRoutes)
                        }
                        else{
                            AllRoutesView(ruta: $ruta)
                        }
                    } else {
                        HStack {
                            if ruta != "" {
                                HStack {
                                    Spacer()
                                    Text("\(ruta)")
                                        .font(.largeTitle)
                                        .bold()
                                        .padding()
                                    Button(action: {
                                        fetchBusRoutes()
                                        ruta = ""
                                    }, label: {
                                        Image(systemName: "multiply.circle.fill")
                                            .resizable(resizingMode: .stretch)
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 30.0, height: 30.0)
                                    })
                                    Spacer()
                                }
                            } else {
                                if(showMore != true){
                                    Spacer()
                                    Text("Todas las rutas")
                                        .font(.largeTitle)
                                        .bold()
                                        .padding()
                                    Spacer()
                                }else{
                                    Spacer()
                                    Text("\(selectedStop!.name)")
                                        .font(.largeTitle)
                                        .bold()
                                        .padding()
                                    Button(action: {
                                        showMore = false
                                    }, label: {
                                        Image(systemName: "multiply.circle.fill")
                                            .resizable(resizingMode: .stretch)
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 30.0, height: 30.0)
                                    })
                                    Spacer()
                                }
                            }
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
            .presentationDetents([.height(120), .medium, .large])
            .presentationCornerRadius(20)
            .presentationBackground(.thinMaterial)
            .presentationBackgroundInteraction(.enabled(upThrough: .height(120)))
            .interactiveDismissDisabled()
            .bottomMaskForSheet()
        }
    }

    func busStops() -> [BusStop] {
        return busRoutes.flatMap { $0.stops }
    }

    func fetchSingleRoute(nombre: String) {
        guard let url = URL(string: "http://10.22.214.232:5000/api/busRoutes/\(nombre)") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching single route:", error?.localizedDescription ?? "Unknown error")
                return
            }
            
            do {
                let route = try JSONDecoder().decode(BusRoute.self, from: data)
                DispatchQueue.main.async {
                    self.busRoutes.removeAll()
                    self.busRoutes.append(route)
                }
            } catch {
                print("Error decoding single route JSON:", error)
            }
        }.resume()
    }

    func fetchBusRoutes() {
        guard let url = URL(string: "http://10.22.214.232:5000/api/busRoutes") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            do {
                let routes = try JSONDecoder().decode([BusRoute].self, from: data)
                DispatchQueue.main.async {
                    self.busRoutes = routes
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}

struct BusRoute: Identifiable, Decodable {
    let id = UUID()
    let name: String
    let stops: [BusStop]
}

struct BusStop: Identifiable, Decodable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let minutes: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case location
        case minutes
    }
    
    enum LocationKeys: String, CodingKey {
        case coordinates
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        
        let locationContainer = try container.nestedContainer(keyedBy: LocationKeys.self, forKey: .location)
        let coordinates = try locationContainer.decode([Double].self, forKey: .coordinates)
        
        coordinate = CLLocationCoordinate2D(latitude: coordinates[1], longitude: coordinates[0])
        minutes = try container.decode(String.self, forKey: .minutes)
    }
}

#Preview {
    MapaView()
}
