//
//  SearchView.swift
//  CWK2Template
//
//  Created by user245489 on 1/16/24.
//

import SwiftUI
import CoreLocation

struct SearchView: View {
    @EnvironmentObject var modelData: ModelData

    // Binding to control the visibility of the search view
    @Binding var isSearchOpen: Bool
    @State var location = ""
    
    // Binding to update the user's location in the main view
    @Binding var userLocation: String
    @State private var errorAlert: Bool = false

    var body: some View {
        ZStack {
            // Background color with opacity
            Color.cyan
                .ignoresSafeArea()
                .opacity(0.5)

            VStack {
                // Title for the search view
                Label("Search Location", systemImage: "location.fill")
                    .font(.title)
                    .foregroundColor(.blue)

                // Text field for entering the new location
                TextField("Enter New Location", text: self.$location, onCommit: {
                    // Geocode the entered location to get its coordinates
                    CLGeocoder().geocodeAddressString(location) { (placemarks, error) in
                        if let lat = placemarks?.first?.location?.coordinate.latitude,
                           let lon = placemarks?.first?.location?.coordinate.longitude {
                            // Use async/await to load weather data for the new coordinates
                            Task {
                                do {
                                    let _ = try await modelData.loadData(lat: lat, lon: lon)
                                    // Update userLocation in the main view
                                    userLocation = location
                                    modelData.userLocation = location
                                } catch {
                                    // Show an alert if an error occurs during data loading
                                    errorAlert = true
                                }
                            }
                            // Close the search view
                            isSearchOpen.toggle()
                        } else {
                            // Show an alert for an invalid location
                            errorAlert = true
                        }
                    }
                })
                .padding(10)
                .shadow(color: .blue, radius: 10)
                .cornerRadius(10)
                .fixedSize()
                .font(.custom("Ariel", size: 26))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .foregroundColor(.black)
                .cornerRadius(15)
                // Display an alert for an invalid location
                .alert(isPresented: $errorAlert) {
                    Alert(
                        title: Text("Invalid Location!"),
                        message: Text("Sorry, we couldn't find the entered location.\nPlease Try Again"),
                        dismissButton: .cancel(Text("Okay"))
                    )
                }
            }
        }
    }
}
