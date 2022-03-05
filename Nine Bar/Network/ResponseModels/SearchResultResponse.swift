//
//  SearchResultResponse.swift
//  Nine Bar
//
//  Created by Iris on 3/4/22.
//

import Foundation

struct SearchResponse: Codable {
    let total: Int
    let businesses: [BusinessInfo]
}

struct BusinessInfo: Codable {
    let id: String
    let name: String
    let imageUrl: String
    let url: String
    let coordinates: [Coordinate]
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl = "image_url"
        case url
        case coordinates
    }
}

struct Coordinate: Codable {
    let latitude: Double
    let longitude: Double
}
