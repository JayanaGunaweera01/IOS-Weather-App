//
//  WindDirHelper.swift
//  WeatherAirCwk
//
//  Created by GirishALukka on 28/03/2023.
//

import Foundation

/// Converts degrees to a cardinal direction.
///
/// - Parameters:
///   - deg: The degree value to be converted.
/// - Returns: A string representing the cardinal direction.
func convertDegToCardinal(deg: Int) -> String {
    // Cardinal directions in 22.5-degree increments
    let cardinalDir = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW", "N"]
    
    // Calculate the index in the cardinalDir array based on the degree value
    let index = Int(round(Double(deg % 360) / 22.5).nextDown) + 1
    
    // Return the corresponding cardinal direction
    return cardinalDir[index]
}
