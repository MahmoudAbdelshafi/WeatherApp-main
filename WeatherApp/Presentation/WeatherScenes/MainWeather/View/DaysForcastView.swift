//
//  DaysStateView.swift
//  WeatherApp
//
//  Created by Mahmoud Abdelshafi on 30/12/2023.
//

import SwiftUI

struct DaysForcastView: View {
    
    let dataModel: [ DayForcastDataModel ]

    var body: some View {
        
        HStack {
            ForEach(dataModel, id: \.feelsLikeInF) { model in
                Spacer()
                DayStateView(viewModel: model)
                Spacer()
            }
        }
    }
}

struct DaysStateView_Previews: PreviewProvider {
    static var previews: some View {
        DaysForcastView(dataModel: []).background {
            Color.blue
        }
        
    }
}


struct DayStateView: View {
    
    let viewModel: DayForcastDataModel
    
    var body: some View {
        VStack(spacing: 6) {
            AsyncImage(url: URL(string: viewModel.image))
                .frame(width: 28, height: 28).padding(.bottom, 8)
            
            Text("\(viewModel.temp)/\(viewModel.feelsLikeInF)F")
                .font(.system(size: 12).weight(.medium)).foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            Text(viewModel.dayName)
                .font(.system(size: 12).weight(.bold)).foregroundColor(.white)
                .multilineTextAlignment(.center)
 
        }
    }
}
