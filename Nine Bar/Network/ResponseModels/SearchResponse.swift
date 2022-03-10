//
//  SearchResultResponse.swift
//  Nine Bar
//
//  Created by Hyun Kim
//

import Foundation

struct Coordinate: Codable {
    let latitude: Double
    let longitude: Double
}

struct BusinessInfo: Codable {
    let id: String
    let name: String
    let isClosed: Bool
    let imageUrl: String
    let url: String
    let coordinates: Coordinate
    let distance: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case isClosed = "is_closed"
        case imageUrl = "image_url"
        case url
        case coordinates
        case distance
    }
}

struct SearchResponse: Codable {
    let total: Int
    let businesses: [BusinessInfo]
}
