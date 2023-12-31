//
//  LocationView.swift
//  WeatherApp
//
//  Created by Mahmoud Abdelshafi on 30/12/2023.
//

import SwiftUI

struct LocationView: View {
    
     var cityName: String
     var date: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            
            //: - Location Text
            
            Text(cityName)
                .font(.system(size: 32).bold()).foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            //: - Date Text
            
            Text(date)
                .font(.system(size: 14).weight(.medium)).foregroundColor(.white)
                .multilineTextAlignment(.center)
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView(cityName: "San Francisco", date: "Tuesday, 12 Apr 2022").background {
            Color.blue
        }
    }
}
