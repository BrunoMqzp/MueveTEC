import SwiftUI
import MapKit

extension MKCoordinateSpan: Equatable {
    public static func == (lhs: MKCoordinateSpan, rhs: MKCoordinateSpan) -> Bool {
        lhs.latitudeDelta == rhs.latitudeDelta && lhs.longitudeDelta == rhs.longitudeDelta
    }
}

struct MapaView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 25.651426, longitude: -100.289570), // Tec de Monterrey
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01) // Default zoom
    )
    
    @State private var busRoutes: [BusRoute] = []
    @State private var showLabels: Bool = true
    
    let routeColors: [Color] = [.blue, .red, .orange, .brown]

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: busStops()) { stop in
            MapAnnotation(coordinate: stop.coordinate) {
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
        .overlay(
            GeometryReader { geometry in
                ZStack {
                    ForEach(busRoutes.indices, id: \.self) { index in
                        let route = busRoutes[index]
                        let color = routeColors[index % routeColors.count]
                        Path { path in
                            let stops = route.stops.map { $0.coordinate }
                            if let firstStop = stops.first {
                                path.move(to: CGPoint(x: geometry.size.width * firstStop.longitude, y: geometry.size.height * firstStop.latitude))
                                for stop in stops.dropFirst() {
                                    path.addLine(to: CGPoint(x: geometry.size.width * stop.longitude, y: geometry.size.height * stop.latitude))
                                }
                            }
                        }
                        .stroke(color, lineWidth: 3)
                    }
                }
            }
        )
        .onAppear {
            fetchBusRoutes()
        }
        .onChange(of: region.span) { newSpan in
            withAnimation(.easeInOut(duration: 0.3)) {
                showLabels = newSpan.latitudeDelta < 0.02 // Toggle label visibility
            }
        }
    }
    
    func busStops() -> [BusStop] {
        return busRoutes.flatMap { $0.stops }
    }
    
    func fetchBusRoutes() {
        guard let url = URL(string: "http://10.22.220.201:5000/api/busRoutes") else { return }
        
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
    
    enum CodingKeys: String, CodingKey {
        case name
        case location
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
    }
}

#Preview {
    MapaView()
}
