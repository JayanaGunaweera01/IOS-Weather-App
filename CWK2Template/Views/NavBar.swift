//
//  NavBar.swift
//  CWK2Template
//
//  Created by girish lukka on 29/10/2023.
//

import SwiftUI

struct NavBar: View {
    
    var body: some View {
        // TabView to organize different views in tabs
        TabView {
            // Home View
            Home()
                .tabItem {
                    Label("City", systemImage: "magnifyingglass")
                }
            
            // WeatherNowView
            WeatherNowView()
                .tabItem {
                    Label("Weather Now", systemImage: "sun.max.fill")
                }
            
            // HourWeatherView
            HourWeatherView()
                .tabItem {
                    Label("Hourly Summary", systemImage: "clock.fill")
                }
            
            // WeatherForecastView
            WeatherForecastView()
                .tabItem {
                    Label("Forecast", systemImage: "calendar")
                }
            
            // TouristPlacesMapView
            TouristPlacesMapView()
                .tabItem {
                    Label("Place Map", systemImage: "map")
                }
        }
        .onAppear {
            // Set the TabBar appearance
            UITabBar.appearance().isTranslucent = false
        }
    }
}
