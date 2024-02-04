//
//  LocationHelper.swift
//  CWK2Template
//
//  Created by user245489 on 1/16/24.
//

import Foundation
import CoreLocation

/// Asynchronously retrieves a location string based on latitude and longitude.
/// - Parameters:
///   - lat: The latitude.
///   - lon: The longitude.
/// - Returns: A string representing the location.
func getLocFromLatLong(lat: Double, lon: Double) async -> String {
    var locationString: String
    var cityString: String
    var countryString: String
    var placemarks: [CLPlacemark]
    
    // Create a coordinate with the given latitude and longitude
    let center: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: lon)
    
    // Initialize a geocoder
    let ceo: CLGeocoder = CLGeocoder()
    
    // Create a location object
    let loc: CLLocation = CLLocation(latitude: center.latitude, longitude: center.longitude)
    
    do {
        // Perform reverse geocoding
        placemarks = try await ceo.reverseGeocodeLocation(loc)
        
        if placemarks.count > 0 {
            // Extract location details from the placemark
            if let name = placemarks[0].name, !name.isEmpty {
                locationString = name
                
                if let country = placemarks[0].country, !country.isEmpty {
                    countryString = country
                    
                    if let locality = placemarks[0].locality, !locality.isEmpty {
                        cityString = locality
                        locationString = "\(locationString),\n\(cityString), \(countryString)"
                    } else {
                        locationString = "\(locationString),\n\(countryString)"
                    }
                }
            } else if let locality = placemarks[0].locality, !locality.isEmpty {
                locationString = locality
            } else {
                locationString = "No City, No Country"
            }
            
            return locationString
        }
    } catch {
        // Handle the error in case of reverse geocoding failure
        print("Reverse geocode fail: \(error.localizedDescription)")
        locationString = "No City, No Country"
        return locationString
    }
    
    // Return an error message if the location retrieval fails
    return "Error getting Location"
}
