//
//  BusinessDetailResponse.swift
//  Nine Bar
//
//  Created by Hyun Kim
//

import Foundation

//struct Photo: Codable {
//    let photo: String
//}

struct Hours: Codable {
    let isOpenNow: Bool
    
    enum CodingKeys: String, CodingKey {
        case isOpenNow = "is_open_now"
    }
}

struct BusinessDetailResponse: Codable {
    let id: String
    let name: String
    let url: String
    let phone: String
    let displayPhone: String
    let photos: [String]
    let hours: [Hours]
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case url
        case phone
        case displayPhone = "display_phone"
        case photos
        case hours
        case imageUrl = "image_url"
    }
}
