//
//  ExpenseMapView.swift
//  HackMTY
//
//  Created by Fausto Pinto Cabrera on 14/09/24.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D{
    static var Garibaldi: CLLocationCoordinate2D {
        return .init(latitude: 40.8525139681341, longitude: 14.272090640839773)
    }
}

extension MKCoordinateRegion{
    static var Napoli: MKCoordinateRegion {
        return .init(center: .Garibaldi, latitudinalMeters: 5000, longitudinalMeters: 15000)
    }
}

struct CoordinateWrapper: Hashable {
    let coordinate: CLLocationCoordinate2D
    
    init(_ coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(coordinate.latitude)
        hasher.combine(coordinate.longitude)
    }
    
    static func ==(lhs: CoordinateWrapper, rhs: CoordinateWrapper) -> Bool {
        return lhs.coordinate.latitude == rhs.coordinate.latitude &&
        lhs.coordinate.longitude == rhs.coordinate.longitude
    }
}

struct ExpenseMapView: View {
    var expense : Expense
    
    @State private var selectedTag : Int?
    @State var camera : MapCameraPosition = .region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.8525139681341,longitude: 14.272090640839773),
        latitudinalMeters: 5000,
        longitudinalMeters: 15000))
    
    var body: some View {
        ZStack {
            Map(position: $camera, selection: $selectedTag){
                Marker(expense.title, coordinate: CLLocationCoordinate2D(latitude: expense.coordinates[0], longitude: expense.coordinates[1]))
                    .tag(expense.id)
                UserAnnotation()
            }
            .mapStyle(.standard)
            .mapControls {
                MapScaleView()
            }
        }
        .onAppear{
            camera = .region(MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: expense.coordinates[0],
                    longitude: expense.coordinates[1]),
                latitudinalMeters: 5000,
                longitudinalMeters: 15000))
        }
    }
}

#Preview {
    ExpenseMapView(
        expense: Expense(id: 0,
                         date: "14/05/2024",
                         amount: -84,
                         category: "Movimiento Banorte",
                         coordinates: [25.652500562449028, -100.28999620365188],
                         summary: "Compra de un café",
                         title: "Starbuck Tecnologico"))
}
