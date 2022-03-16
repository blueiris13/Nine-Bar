//
//  NetworkConstants.swift
//  Nine Bar
//
//  Created by Hyun Kim
//

import Foundation


struct YelpServer {
    static let baseURL = "https://api.yelp.com"
}

struct APIKey {
    static let key = "Bearer A3raGd3_WiixXXvKhLyX5_vhKO5q-L0Tx8WaFDjjkmujVExknlRDoo5Pt77ML1yJ9MUByQNMihO1lc-cmyrQCz56cwySGgiFHq0JflDyvlTmKk_k_y5CvzHiZsYhYnYx"
}

struct APIParameterKey{
    static let latitude = "latitude"
    static let longitude = "longitude"
    static let limit = "limit"
    static let categories = "categories"
    static let businessID = "id"
    static let openNow = "open_now"
    static let sortyBy = "sort_by"
}

struct APIParameterValue {
    static let categories = "coffee,coffeeshop,coffeeroasteries"
    static let limit = 10
    static let businessID = "some ddd"
    static let isOpenNow = true
    static let sortBy = "distance"

}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
}

enum ContentType: String {
    case json = "application/json"
}
