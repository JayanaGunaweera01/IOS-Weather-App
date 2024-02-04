//
//  DailyWeatherView.swift
//  CWK2Template
//
//  Created by girish lukka on 02/11/2023.
//

import SwiftUI

struct DailyWeatherView: View {
    var day: Daily // Daily weather data for a specific day
   
    var body: some View {
        HStack {
            // Display the weather icon for the day using AsyncImage
            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(day.weather[0].icon)@2x.png")) { phase in
                if let image = phase.image {
                    image
                } else if phase.error != nil {
                    Image(systemName: "exclamationmark.triangle")
                } else {
                    ProgressView()
                }
            }
            
            Spacer() // Add spacing
            
            VStack {
                // Display the weather description (e.g., "Clear sky") in subheadline font
                Text("\(day.weather[0].weatherDescription.rawValue.capitalized)")
                    .font(.subheadline)
                    .fontWeight(.bold)
                
                // Display the day of the week and day of the month
                Text("\(Date(timeIntervalSince1970: TimeInterval((Int)(day.dt))).formatted(.dateTime.weekday(.wide).day()))")
                    .font(.caption)
            }
        
            Spacer() // Add spacing
            
            HStack {
                // Display the maximum temperature for the day in callout font
                Text("\((Int)(day.temp.max))ºC")
                    .font(.callout)
                    .fontWeight(.bold)
                
                // Display a slash (/) as a separator
                Text("/")
                    .font(.callout)
                
                // Display the minimum temperature for the day in callout font
                Text("\((Int)(day.temp.min))ºC")
                    .font(.callout)
                    .fontWeight(.bold)
            }
        }
    }
}

struct DailyWeatherView_Previews: PreviewProvider {
    static var day = ModelData().forecast!.daily
    
    static var previews: some View {
        DailyWeatherView(day: day[0])
    }
}
