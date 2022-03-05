//
//  NetworkConstants.swift
//  Nine Bar
//
//  Created by Hyun Kim
//

import Foundation

struct K {
    struct YelpSerer {
        static let baseURL = "https://api.yelp.com/v3"
    }

    struct APIParameterKey{
        static let searchText = "searchText"
        static let businessID = 0
    }
}

enum HTTPHeaderField: String {
    case contentType = "Content-Type"
}

enum ContentType: String {
    case json = "application/json"
}
