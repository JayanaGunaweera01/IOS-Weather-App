//
//  WeatherNowView.swift
//  CWK2Template
//
//  Created by girish lukka on 29/10/2023.
//

import SwiftUI

struct WeatherNowView: View {
    // Access to the shared model data
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Spacer()
                
                // User location
                Text(modelData.userLocation)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                
                VStack(spacing: 20) {
                    // Current weather icon and description
                    HStack {
                        AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(modelData.forecast!.current.weather[0].icon).png")) { phase in
                            if let image = phase.image {
                                image
                            } else if phase.error != nil {
                                Image(systemName: "exclamationmark.triangle")
                            } else {
                                ProgressView()
                            }
                        }
                        Text("\(modelData.forecast!.current.weather[0].weatherDescription.rawValue.capitalized)")
                            .font(.headline)
                    }
                    
                    // Current temperature
                    HStack {
                        Text("\((Int)(modelData.forecast!.current.temp))")
                            .font(.system(size: 150, weight: .medium, design: .default))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [Color(UIColor.systemGray6), Color(UIColor.lightGray)],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                        Text("ºC")
                    }
                    
                    // Feels like, max and min temperature
                    VStack(spacing: 10) {
                        HStack(spacing: 15) {
                            Label("Feels Like", systemImage: "thermometer.medium")
                            Text("\((Int)(modelData.forecast!.current.feelsLike))ºC")
                        }
                        
                        HStack(spacing: 20) {
                            Label("\((Int)(modelData.forecast!.daily[0].temp.max))ºC", systemImage: "arrow.up")
                            Label("\((Int)(modelData.forecast!.daily[0].temp.min))ºC", systemImage: "arrow.down")
                        }
                    }
                }
                
                // Sunrise and sunset information
                HStack(spacing: 30) {
                    Label("\(Date(timeIntervalSince1970: TimeInterval((Int)(modelData.forecast?.current.sunrise ?? 0))).formatted(.dateTime.hour().minute()))", systemImage: "sunrise.fill")
                        .symbolRenderingMode(.multicolor)
                        .font(.headline)
                        .padding()
                        .padding(.horizontal)
                        .background {
                            Color
                                .white
                                .opacity(0.1)
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                        }
                    
                    Label("\(Date(timeIntervalSince1970: TimeInterval((Int)(modelData.forecast?.current.sunset ?? 0))).formatted(.dateTime.hour().minute()))", systemImage: "sunset.fill")
                        .symbolRenderingMode(.multicolor)
                        .font(.headline)
                        .padding()
                        .padding(.horizontal)
                        .background {
                            Color
                                .white
                                .opacity(0.1)
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                        }
                }
                
                Spacer()
                
                // Additional weather details
                HStack(spacing: 10) {
                    Spacer()
                    VStack(alignment: .trailing, spacing: 30) {
                        Image(systemName: "wind")
                        Image(systemName: "lines.measurement.horizontal")
                        Image(systemName: "humidity")
                        Image(systemName: "water.waves.and.arrow.down")
                    }
                    VStack(alignment: .leading, spacing: 30) {
                        Text("Wind Speed")
                        Text("Direction")
                        Text("Humidty")
                        Text("Pressure")
                    }
                    .padding(.trailing, 10)
                    VStack(alignment: .leading, spacing: 30) {
                        Text("\((Int)(modelData.forecast!.current.windSpeed))m/s")
                        Text("\(convertDegToCardinal(deg: modelData.forecast!.current.windDeg))")
                        Text("\((Int)(modelData.forecast!.current.humidity))%")
                        Text("\((Int)(modelData.forecast!.current.pressure))hPa")
                    }
                    Spacer()
                }
                Spacer()
            }
        }
        // Styling with a background image
        .foregroundColor(.white)
        .background(
            Image("background2")
                .resizable()
                .scaledToFill()
                .overlay(Color.black.opacity(0.7))
                .ignoresSafeArea()
        )
    }
}

struct WeatherNowView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherNowView()
            .environmentObject(ModelData())
    }
}
