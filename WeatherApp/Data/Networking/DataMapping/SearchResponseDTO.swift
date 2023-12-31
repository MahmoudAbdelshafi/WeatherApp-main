//
//  SearchResponseDTO.swift
//  WeatherApp
//
//  Created by Mahmoud Abdelshafi on 30/12/2023.
//

import Foundation

// MARK: - SearchResponseDTO

struct SearchResponseDTO: Codable {
    let id: Int?
    let name: String?
    let region: String?
    let country: String?
    let lat, lon: Double?
    let url: String?
}

typealias SearchResponseArray = [SearchResponseDTO]

//MARK: - SearchResponseDTO To Domain

extension SearchResponseDTO {
    
    func toDomain() -> SearchDataModel {
        return SearchDataModel(name: self.name ?? "",
                               region: self.region ?? "",
                               country: self.country ?? "")
    }
}

//MARK: - SearchResponseArray To Domain

extension SearchResponseArray {
    
    func toDomain() -> [SearchDataModel] {
        self.map { $0.toDomain() }
    }
}
