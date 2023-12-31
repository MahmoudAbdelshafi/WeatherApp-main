//
//  TopSearchView.swift
//  WeatherApp
//
//  Created by Mahmoud Abdelshafi on 30/12/2023.
//

import SwiftUI

struct TopSearchView: View {
    
    var dismiss: ((SearchDataModel? )->())?
    var search: ((String)->())?
    
    @State private var searchText = ""
    var searchData: [SearchDataModel]
    private let radius: CGFloat = 30
    @State private var viewHeight: CGFloat = 110
   
    var body: some View {
        
        //: - Bind searchText Changes
        let _ = Binding<String>(get: {
            DispatchQueue.main.async {
                withAnimation(.easeOut(duration: 0.4)) {
                    
                    if !searchText.isEmpty {
                        viewHeight = 350
                    } else {
                        viewHeight = 110
                    }
                }
            }
            if searchText.count > 2 {
                search?(searchText)
            }
            return self.searchText
        }, set: {
           
            self.searchText = $0
        })
        
        VStack {
            
            HStack(spacing: 14) {
                Spacer()
                Image("back")
                    .resizable()
                    .frame(width: 14, height: 12)
                    .onTapGesture {
                        dismiss?(nil)
                    }
                
                TextField("Search City", text: $searchText)
                
                    .frame(height: 50)
                    .padding(.leading, 20)
                    .foregroundColor(.black)
                
                    .font(.body)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color(hex: "444E72"), lineWidth: 1)
                    )
                
            } //: - HStack
            .padding(.top, 30)
            .padding(.leading, 31)
            .padding(.trailing, 32)
            
            List(searchData, id: \.region) { data in
                
                HStack(spacing: 0) {
                    Text(data.name + " - ")
                        .font(.system(size: 16).weight(.bold)).foregroundColor(Color(hex: "444E72"))
                        .multilineTextAlignment(.leading).listRowBackground(Color.white)
                    
                    Text(data.region)
                        .font(.system(size: 16).weight(.medium)).foregroundColor(Color(hex: "444E72"))
                        .multilineTextAlignment(.leading).listRowBackground(Color.white)
                        
                }.listRowSeparator(.hidden)
                    .onTapGesture {
                        dismiss?(data)
                    }
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.white)
            .padding(.top, 0)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .scrollContentBackground(.hidden)
            .preferredColorScheme(.light)
            
            //: - Bottom Line View
            if viewHeight > 300 {
                Rectangle()
                    .background {
                        Color(hex: "F1F4FF")
                        HStack(alignment: .center) {
                            
                            Button(action: {
                                
                            }, label: {
                                Image("arrow_up")
                                    .resizable()
                                    .frame(width: 13, height: 8, alignment: .center)
                            }).frame(maxWidth: .infinity, maxHeight: .infinity)
                            
                        }
                    }.onTapGesture {
                        dismiss?(nil)
                    }
                    .frame(height: 38)
                    .foregroundColor(.clear)
                    .padding(.top, radius)
                    .cornerRadius(radius)
                    .padding(.top, -radius)
            }//: - Bottom Line View
            
        } //: - VStack
        .frame(height: viewHeight)
        .background(Color.white)
        .padding(.top, 20)
        .preferredColorScheme(.light)
        .padding(.top, radius)
        .cornerRadius(radius)
        .padding(.top, -radius)
        .onAppear{
            setupColorScheme(false)
        }
        
    }
    
    private func setupColorScheme(_ isDarkMode: Bool) {
        let keyWindow = UIApplication.shared.connectedScenes
               .filter({$0.activationState == .foregroundActive})
               .compactMap({$0 as? UIWindowScene})
               .first?.windows
               .filter({$0.isKeyWindow}).first
        keyWindow?.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
    }
}
