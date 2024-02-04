//
//  WeatherMapViewModel.swift
//  CWK2Template
//
//  Created by girish lukka on 29/10/2023.
//

import SwiftUI
import CoreLocation
import MapKit

struct TouristPlacesMapView: View {
    @EnvironmentObject private var weatherMapViewModel: WeatherMapViewModel
    @StateObject private var placeviewModel = PlacesViewModel()

    @State private var locations: [Location] = []
    @State private var selectedLocation: Location? = nil
    @State private var isShowDetails = false

    @State private var touristLocationIndex = 0

    @State private var mapCameraPosition = MapCameraPosition.camera(
        MapCamera(
            centerCoordinate: CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522), // Paris as the initial center
            distance: 3000000.0 // Adjust the distance as needed
        )
    )

    // Calculate the map camera position based on the selected location's coordinate
    private func calculateMapCameraPosition(coordinate: CLLocationCoordinate2D) {
        mapCameraPosition = MapCameraPosition.camera(
            MapCamera(centerCoordinate: coordinate, distance: 3000000.0)
        )
    }

    // Move to the next tourist place
    private func nextPlace() {
        if locations.count - 1 > touristLocationIndex {
            touristLocationIndex += 1
            calculateMapCameraPosition(coordinate: locations[touristLocationIndex].coordinates)
        }
    }

    // Move to the previous tourist place
    private func prevPlace() {
        if 0 < touristLocationIndex {
            touristLocationIndex -= 1
            calculateMapCameraPosition(coordinate: locations[touristLocationIndex].coordinates)
        }
    }

    // Map navigation UI (back to central location and check tourist places)
    var mapNav: some View {
        VStack {
            Button(action: {
                // Back to central location
                calculateMapCameraPosition(coordinate: weatherMapViewModel.coordinates ??
                    CLLocationCoordinate2D(latitude: 51.5216871, longitude: -0.1391574))
            }) {
                Image(systemName: "location.fill")
                    .font(.title)
                    .foregroundColor(.blue)
            }
            .buttonStyle(.plain)
            .padding(20.0)

            // Check tourist places navigation buttons
            VStack {
                Button(action: {
                    nextPlace()
                }) {
                    Image(systemName: "arrow.up")
                        .font(.title)
                        .foregroundColor(.blue)
                }
                .buttonStyle(.plain)

                Button(action: {
                    prevPlace()
                }) {
                    Image(systemName: "arrow.down")
                        .font(.title)
                        .foregroundColor(.blue)
                }
                .buttonStyle(.plain)
            }
            .padding(20.0)
        }
    }

    var body: some View {
        ZStack {
            // Map
            Map(
                position: $mapCameraPosition
            ) {
                // Searched Location pin
                if let coordinates = weatherMapViewModel.coordinates {
                    Annotation(weatherMapViewModel.city, coordinate: coordinates) {
                        Label("", systemImage: "pin.fill")
                            .font(.title2)
                            .foregroundStyle(.red)
                    }
                }

                // Places pins
                ForEach(locations) { location in
                    Annotation(location.name, coordinate: location.coordinates) {
                        Image(location.imageNames.first ?? "mappin")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.leading, 15.0)
                            .frame(width: 90, height: 90)
                            .onTapGesture {
                                isShowDetails = true
                                selectedLocation = location
                            }
                    }
                }
            }
            .mapControlVisibility(.visible)
            .overlay(alignment: .topTrailing) {
                mapNav
            }

            // Loading
            if weatherMapViewModel.weatherDataModel == nil {
                ZStack {
                    Rectangle().opacity(0.0)
                        .ignoresSafeArea()

                    ProgressView("Progressing Map...")
                        .font(.headline)
                        .progressViewStyle(CircularProgressViewStyle())
                        .tint(.blue)
                        .foregroundColor(.white)
                }
            }

            // Places Data show
            if isShowDetails, let selectedLocation = selectedLocation {
                LocationDataView(locationData: selectedLocation, isShow: $isShowDetails)
            }
        }
        .onAppear() {
            // Filter locations
            locations = placeviewModel.locations.filter { $0.cityName == weatherMapViewModel.city ||
                                                         $0.cityName == "Paris" || $0.cityName == "Rome" }

            // Set camera position
            calculateMapCameraPosition(coordinate: weatherMapViewModel.coordinates ??
                CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522)) // Set initial center to Paris
        }
    }
}

struct TouristPlacesMapView_Previews: PreviewProvider {
    static var previews: some View {
        TouristPlacesMapView().environmentObject(WeatherMapViewModel())
    }
}
