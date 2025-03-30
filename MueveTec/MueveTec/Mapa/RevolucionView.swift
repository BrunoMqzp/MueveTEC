//
//  RevolucionView.swift
//  MueveTec
//
//  10.22.214.232 by Ranferi Márquez Puig on 29/03/25.
//

import SwiftUI
import MapKit

struct CustomBusRoute: Identifiable, Codable {
    let id: String
    let name: String
    let stops: [CLLocationCoordinate2D]
    
    enum CodingKeys: String, CodingKey {
        case id, name, stops
    }
    
    init(id: String, name: String, stops: [CLLocationCoordinate2D]) {
        self.id = id
        self.name = name
        self.stops = stops
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        let stopDictionaries = try container.decode([[String: Double]].self, forKey: .stops)
        stops = stopDictionaries.map { CLLocationCoordinate2D(latitude: $0["latitude"] ?? 0, longitude: $0["longitude"] ?? 0) }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        let stopDictionaries = stops.map { ["latitude": $0.latitude, "longitude": $0.longitude] }
        try container.encode(stopDictionaries, forKey: .stops)
    }
}

class BusRouteViewModel: ObservableObject {
    @Published var routes: [CustomBusRoute] = []
    @Published var polylines: [MKPolyline] = []
    
    func fetchBusRoutes() {
        guard let url = URL(string: "http://10.22.214.232:5000/api/busRoutes") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            do {
                let decodedRoutes = try JSONDecoder().decode([CustomBusRoute].self, from: data)
                DispatchQueue.main.async {
                    self.routes = decodedRoutes
                    self.createPolylines()
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
    
    func createPolylines() {
        polylines = routes.map { route in
            let coordinates = route.stops.map { CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude) }
            return MKPolyline(coordinates: coordinates, count: coordinates.count)
        }
    }
}

struct BusRouteMapView: UIViewRepresentable {
    @ObservedObject var viewModel: BusRouteViewModel
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.removeOverlays(mapView.overlays)
        mapView.addOverlays(viewModel.polylines)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: BusRouteMapView
        
        init(_ parent: BusRouteMapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            guard let polyline = overlay as? MKPolyline else { return MKOverlayRenderer() }
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = UIColor.random()
            renderer.lineWidth = 3
            return renderer
        }
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red: CGFloat.random(in: 0...1),
            green: CGFloat.random(in: 0...1),
            blue: CGFloat.random(in: 0...1),
            alpha: 1.0
        )
    }
}

struct RevolucionView: View {
    @StateObject private var viewModel = BusRouteViewModel()
    
    var body: some View {
        BusRouteMapView(viewModel: viewModel)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                viewModel.fetchBusRoutes()
            }
    }
}

struct BusRoutesApp: App {
    var body: some Scene {
        WindowGroup {
            RevolucionView()
        }
    }
}
