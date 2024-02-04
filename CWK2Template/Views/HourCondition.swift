//
//  HourCondition.swift
//  CWK2Template
//
//  Created by user245489 on 1/16/24.
//

import SwiftUI

struct HourCondition: View {
    var current: Current

    var body: some View {
        HStack {
            // Display time and weekday
            VStack {
                Text("\(Date(timeIntervalSince1970: TimeInterval((Int)(current.dt))).formatted(.dateTime.hour()))")
                    .font(.headline)
                    .fontWeight(.medium)
                Text("\(Date(timeIntervalSince1970: TimeInterval((Int)(current.dt))).formatted(.dateTime.weekday()))")
                    .font(.footnote)
            }

            Spacer()

            // Display weather icon using AsyncImage
            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(current.weather[0].icon)@2x.png")) { phase in
                if let image = phase.image {
                    image
                } else if phase.error != nil {
                    Image(systemName: "exclamationmark.triangle")
                } else {
                    ProgressView()
                }
            }

            Spacer()

            // Display temperature and weather description
            HStack(spacing: 20) {
                Text("\((Int)(current.temp))ºC")
                    .font(.title2)
                Text("\(current.weather[0].weatherDescription.rawValue.capitalized)")
                    .font(.subheadline)
            }
        }
        .padding(.horizontal)
    }
}

struct HourCondition_Previews: PreviewProvider {
    static var hourly = ModelData().forecast!.hourly

    static var previews: some View {
        HourCondition(current: hourly[0])
    }
}
