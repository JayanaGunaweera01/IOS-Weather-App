//
//  CWK2TemplateApp.swift
//  CWK2Template
//
//  Created by girish lukka on 29/10/2023.
//

import SwiftUI

@main
struct TouristWeatherExplorer: App {
    @StateObject var weatherMapViewModel = WeatherMapViewModel()
    @StateObject var modelData = ModelData()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
                .environmentObject(weatherMapViewModel)
        }
    }
}
