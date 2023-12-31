//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by Mahmoud Abdelshafi on 30/12/2023.
//

import SwiftUI

struct CurrentWeatherView: View {
    
    var weatherState: String
    var temp: String
    var windSpeed: String
    var humidity: String
    var image: String
   
    var body: some View {
        
        VStack(spacing: 18) {
            
            // - Weather state image
            AsyncImage(url: URL(string: image))
                .frame(width: 70, height: 70)
            
            // - Current wather text
            
            Text(temp + "F")
                .font(.system(size: 56).weight(.heavy)).foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            // - Weather state text
            
            Text("It’s a \(weatherState.lowercased()) day.")
                .font(.system(size: 16).weight(.medium)).foregroundColor(.white)
                .multilineTextAlignment(.center)
            HStack(spacing: 44) {
                HorizontalStateView(image: "wind",
                                    speed: "\(windSpeed) mph",
                                    imageWidth: 16.66,
                                    imageHeight: 13.33)
                
                HorizontalStateView(image: "water_drop",
                                    speed: "\(humidity)%",
                                    imageWidth: 13.3,
                                    imageHeight: 16.1)
            }
        }
    }
    
    
}

struct CurrentWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView(weatherState: "sunny",
                           temp: "82.4°F",
                           windSpeed: "3",
                           humidity: "5",
                           image: "https://cdn.weatherapi.com/weather/64x64/night/113.png").background {
            Color.blue
        }
    }
}


struct HorizontalStateView: View {
    var image: String
    var speed: String
    var imageWidth: CGFloat
    var imageHeight: CGFloat
    
    var body: some View {
       
            HStack(spacing: 8) {
                Image(image)
                    .resizable()
                    .frame(width: imageWidth, height: imageHeight)
                
                Text(speed)
                    .font(.system(size: 12).weight(.medium)).foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }
    }
}
