//
//  LocationHelper.swift
//  CWK2Template
//
//  Created by user245489 on 1/16/24.
//

import Foundation

class ModelData: ObservableObject {
    
    @Published var forecast: Forecast?
    @Published var userLocation: String = ""
    
    private let API_KEY = "ENTER_YOUR_API_KEY_HERE"
    
    // Initialize the ModelData with the forecast for London from a local JSON file
    init() {
        self.forecast = load("london.json")
    }

    // Asynchronously load weather forecast data from the OpenWeather API
    func loadData(lat: Double, lon: Double) async throws -> Forecast {
        let url = URL(string: "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&units=metric&appid=\(API_KEY)")
        let session = URLSession(configuration: .default)
        
        let (data, _) = try await session.data(from: url!)
        
        do {
            let forecastData = try JSONDecoder().decode(Forecast.self, from: data)
            // Update the forecast property on the main thread
            DispatchQueue.main.async {
                self.forecast = forecastData
            }
            
            return forecastData
        } catch {
            // Propagate any decoding errors
            throw error
        }
    }
    
    // Load forecast data from a local JSON file
    func load<Forecast: Decodable>(_ filename: String) -> Forecast {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in the main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from the main bundle:\n\(error)")
        }
        
        do {
            // Decode and return the forecast data
            let decoder = JSONDecoder()
            return try decoder.decode(Forecast.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(Forecast.self):\n\(error)")
        }
    }
}
