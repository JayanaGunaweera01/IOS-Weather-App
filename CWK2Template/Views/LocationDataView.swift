//
//  LocationDataView.swift
//  CWK2Template
//
//  Created by user245489 on 1/16/24.
//

import SwiftUI

struct LocationDataView: View {
    
    var locationData: Location // Location data to display
    @Binding var isShow: Bool // Binding to control the visibility of the view
    @State private var selectedImageIndex = 0 // State to keep track of the selected image index
    
    private func nextImage() {
        // Move to the next image if available
        if selectedImageIndex < locationData.imageNames.count - 1 {
            selectedImageIndex += 1
        }
    }
    
    private func preImage() {
        // Move to the previous image if available
        if selectedImageIndex > 0 {
            selectedImageIndex -= 1
        }
    }
    
    var body: some View {
        ZStack {
            // Background overlay to close the view on tap
            Rectangle()
                .fill(.white)
                .opacity(0.1)
                .ignoresSafeArea()
                .onTapGesture {
                    isShow = false
                    print("close")
                }
            
            // Main content view
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.blue.opacity(0.6))
                .blur(radius: 6)
                .frame(minHeight: 200, maxHeight: 500)
                .padding(.horizontal, 20.0)
            
            VStack {
                HStack {
                    // Navigation button to go to the previous image
                    Label("", systemImage: "arrow.backward.circle")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .onTapGesture {
                            preImage()
                        }
                    
                    // Display the selected image
                    Image(locationData.imageNames[selectedImageIndex])
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.all, 8.0)
                        .frame(minWidth: 50, maxWidth: .infinity, minHeight: 50)
                    
                    // Navigation button to go to the next image
                    Label("", systemImage: "arrow.forward.circle")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .onTapGesture {
                            nextImage()
                        }
                }
                .padding(.horizontal, 10.0)
                
                // Location details
                Text("\(locationData.name)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                
                Text("\(locationData.cityName)")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                
                Text("\(locationData.description)")
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding()
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                // Link to more information
                Link("More Info", destination: URL(string: "\(locationData.link)")!)
                    .tint(.white)
                    .underline(true)
                    .padding()
            }
            .frame(minHeight: 200, maxHeight: 500)
            .padding(.horizontal, 20.0)
        }
    }
}
