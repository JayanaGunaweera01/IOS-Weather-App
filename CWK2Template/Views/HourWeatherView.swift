//
//  HourWeatherView.swift
//  CWK2Template
//
//  Created by girish lukka on 02/11/2023.
//

import SwiftUI

struct HourWeatherView: View {
    
    @EnvironmentObject var modelData: ModelData

    var body: some View {
        VStack {
            VStack {
                // Display the user's location
                Text(modelData.userLocation)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    
                // List to show the hourly weather conditions
                List {
                    ForEach(modelData.forecast!.hourly) { hour in
                        // Display the weather condition for each hour
                        HourCondition(current: hour)
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

struct HourWeatherPreviews: PreviewProvider {
    static var previews: some View {
        HourWeatherView().environmentObject(ModelData())
    }
}
