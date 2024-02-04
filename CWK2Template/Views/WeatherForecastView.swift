//
//  WeatherForcastView.swift
//  CWK2Template
//
//  Created by girish lukka on 29/10/2023.
//

import SwiftUI

struct WeatherForecastView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        VStack {
            VStack {
                // Display the user's location
                Text(modelData.userLocation)
                    .font(.title3)
                    .multilineTextAlignment(.center)

                // List to show the daily weather forecast
                List {
                    ForEach(modelData.forecast!.daily) { day in
                        // Display the weather information for each day
                        DailyWeatherView(day: day)
                    }
                }
                .foregroundColor(.black) // Set the text color of the list items
            }
            .opacity(0.8) // Adjust the opacity of the inner VStack
        }
        .foregroundColor(.white) // Set the text color of the outer VStack
        .background(
            // Background image with overlay to create a semi-transparent effect
            Image("background")
                .resizable()
                .scaledToFill()
                .overlay(Color.black.opacity(0.7))
                .ignoresSafeArea()
        )
    }
}

struct Weather_Forecast_Previews: PreviewProvider {
    static var previews: some View {
        WeatherForecastView().environmentObject(ModelData())
    }
}
