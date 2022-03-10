//
//  BusinessDetailResponse.swift
//  Nine Bar
//
//  Created by Hyun Kim
//

import Foundation

struct Photo: Codable {
    let photo: String
}

struct Hours: Codable {
    let isOpenNow: Bool
    
    enum CodingKeys: String, CodingKey {
        case isOpenNow = "is_open_now"
    }
}

struct BusinessDetailResponse: Codable {
    let name: String
    let url: String
    let phone: String
    let displayPhone: String
    let photos: [Photo]
    let hours: [Hours]

    enum CodingKeys: String, CodingKey {
        case name
        case url
        case phone
        case displayPhone = "display_phone"
        case photos
        case hours
    }
}
