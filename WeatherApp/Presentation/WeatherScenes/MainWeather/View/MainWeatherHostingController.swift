//
//  MainWeatherHostingController.swift
//  WeatherApp
//
//  Created by Mahmoud Abdelshafi on 30/12/2023.
//

import UIKit
import Combine
import SwiftUI

class MainWeatherHostingController: UIHostingController<MainView<DefaultMainWeatherViewModel>> {
    
    override init(rootView: MainView<DefaultMainWeatherViewModel>) {
        super.init(rootView: rootView)
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

struct MainView<T : MainWeatherViewModel> : View {
    
    //MARK: - Properties
    
    @State private var showingAlert = false
    @State private var searchPressed = false
    
    @ObservedObject var viewModel: T
    
    //MARK: - Body
    
    var body: some View {
        
        NavigationView {
            
            //MARK: - Main Screen Componens
            
            ZStack {
                
                Image("launch_screen")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea(.all)
                    .overlay {
                        Color(hex: "002762D4")
                            .ignoresSafeArea()
                    }
                
                VStack() {
                    
                    Spacer()
                    
                    //MARK: - LocationView
                    
                    LocationView(cityName: viewModel.cityName, date: viewModel.date)
                    
                    Spacer()
                    
                    //MARK: - Current Weather Data View
                    
                    CurrentWeatherView(weatherState: viewModel.weatherStatus,
                                       temp: viewModel.temp,
                                       windSpeed: viewModel.windSpeed,
                                       humidity: viewModel.humidity,
                                       image: viewModel.weatherImg)
                    //: - Aleart
                    
                    .alert("Please enable location Service form your settings", isPresented: $showingAlert) {
                        Button("Settings", role: .cancel) {
                            settingsOpener()
                        }
                        
                        Button("Dismiss", role: .destructive) {
                        }
                    }
                    
                    Spacer()
                    
                    //MARK: - Days Forcast View
                    
                    DaysForcastView(dataModel: viewModel.daysData)
                    Spacer()
                }//: - VStack
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                
            } //: - ZStack
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    if !searchPressed {
                        Text(viewModel.currentTime)
                            .font(.system(size: 16)).foregroundColor(.white)
                    }
                }
                
                if !searchPressed {
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: {
                            withAnimation(.easeOut(duration: 0)) {
                                searchPressed.toggle()
                            }
                        }, label: {
                            HStack {
                                Image("search")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .padding(.leading, -37)
                            }
                        }).frame(width: 60, height: 60)
                    }
                }
            }//: - Toolbar
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .toolbarBackground(
                Color.white,
                for: .navigationBar)
            .toolbarBackground( searchPressed ? .visible : .hidden, for: .navigationBar)
            .ignoresSafeArea()
            .onTapGesture {
                withAnimation(.easeOut(duration: 0.3)) {
                    searchPressed = false
                }
            }
            
            //- Overlay TopSearch Screen
            
            .overlay(alignment: .top, content: {
                if searchPressed {
                    TopSearchView (dismiss: { dataModel in
                        if dataModel != nil {
                            viewModel.loadWeatherData(cityName: dataModel?.region ?? "")
                        }
                        withAnimation(.easeOut(duration: 0.3)) {
                            searchPressed.toggle()
                        }
                    }, search: { text in
                        viewModel.search(with: text)
                    }, searchData: viewModel.searchData)
                }
                
            })
        }//: - Navigation View
        .onAppear {
            viewModel.viewAppeared()
            showingAlert = LocationManager.authorizationStatus == .denied ? true : false
        }
        .preferredColorScheme(.dark)
        .ignoresSafeArea(.keyboard, edges: .bottom)
        
    }
    
    //MARK: - Private functions
    
    private func settingsOpener() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}

