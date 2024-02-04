//
//  PlacesViewModel.swift
//  CWK2Template
//
//  Created by user245489 on 1/16/24.
//

import Foundation
import SwiftUI
import CoreLocation

class PlacesViewModel: ObservableObject {
    // MARK: Published variable to store locations
    @Published var locations: [Location] = []

    // Initialization to load data when the object is created
    init() {
        loadData()
    }

    // Load locations data from the "places.json" file
    func loadData() {
        if let url = Bundle.main.url(forResource: "places", withExtension: "json") {
            do {
                // Read data from the JSON file
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()

                // Decode JSON data into an array of Location objects
                locations = try decoder.decode([Location].self, from: data)
            } catch {
                // Handle errors if any occur during data loading
                print("Error loading places data: \(error)")
            }
        }
    }
}
