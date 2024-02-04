//
//  SearchView.swift
//  CWK2Template
//
//  Created by user245489 on 1/16/24.
//

import SwiftUI
import CoreLocation

struct Home: View {
    
    @EnvironmentObject var modelData: ModelData
    @State var isSearchOpen: Bool = false
    @State var userLocation: String = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Spacer()
                
                VStack {
                    Text(userLocation)
                        .font(.title3)
                        .multilineTextAlignment(.center)
                    
                    Button {
                        self.isSearchOpen.toggle()
                    } label: {
                        Label("Change Location", systemImage: "magnifyingglass")
                            .font(.system(size: 15))
                    }
                    .sheet(isPresented: $isSearchOpen) {
                        SearchView(isSearchOpen: $isSearchOpen, userLocation: $userLocation)
                    }
                    .padding(8.0)
                    .padding(.horizontal)
                    .background {
                        Color
                            .white
                            .opacity(0.1)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                    }
                }
                
                Spacer()
                
                VStack(spacing: 20) {
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
                    .padding(.horizontal)
                    
                    VStack {
                        Text(Date(timeIntervalSince1970: TimeInterval(((Int)(modelData.forecast?.current.dt ?? 0))))
                            .formatted(.dateTime.weekday(.wide).year().month().day()))
                        .font(.subheadline)
                        .fontWeight(.thin)
                        .textCase(.uppercase)
                        
                        Text(Date(timeIntervalSince1970: TimeInterval(((Int)(modelData.forecast?.current.dt ?? 0))))
                            .formatted(.dateTime.hour().minute()))
                        .font(.subheadline)
                        .fontWeight(.thin)
                    }
                    
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
                    
                }
            
                Spacer()
                
                HStack(spacing: 10) {
                    Spacer()
                    VStack(alignment: .trailing, spacing: 30) {
                        Label("Humidity", systemImage: "humidity")
                            .padding(.horizontal)
                        Label("Pressure", systemImage: "water.waves.and.arrow.down")
                            .padding(.horizontal)
                    }
                    VStack(alignment: .leading, spacing: 30) {
                        Text("\((Int)(modelData.forecast!.current.humidity))%")
                        Text("\((Int)(modelData.forecast!.current.pressure))hPa")
                    }
                    
                    Spacer()
                    
                }
                
            }
            .onAppear {
                Task.init {
                    self.userLocation = await getLocFromLatLong(lat: modelData.forecast!.lat, lon: modelData.forecast!.lon)
                    self.modelData.userLocation = self.userLocation
                    
                }
            }
        }
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

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(ModelData())
    }
}
