//
//  APIRouter.swift
//  Nine Bar
//
//  Created by Hyun Kim
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case businessSearch(latitude: Double, longitude: Double, limit: Int, categories: String, openNow: Bool, sortBy: String)
    case businessDetail(businessID: String)
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .businessSearch, .businessDetail:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .businessSearch:
            return "/v3/businesses/search"
        case .businessDetail(let id):
            return "/v3/businesses/\(id)"
        }
        
    }
    
    private var queryItems: [URLQueryItem] {
        switch self {
        case .businessSearch(let latitude, let longitude, let limit, let categories, let isOpenNow, let sortBy):
            return [
                URLQueryItem(name: APIParameterKey.latitude, value: "\(latitude)"),
                URLQueryItem(name: APIParameterKey.longitude, value: "\(longitude)"),
                URLQueryItem(name: APIParameterKey.limit, value: "\(limit)"),
                URLQueryItem(name: APIParameterKey.categories, value: "\(categories)"),
                URLQueryItem(name: APIParameterKey.openNow, value: "\(isOpenNow)"),
                URLQueryItem(name: APIParameterKey.sortyBy, value: "\(sortBy)")
            ]
        case .businessDetail:
            return []
        }
    }
    
    // MARK: - Parameters
    
    private var parameters: Parameters? {
        switch self {
        case .businessSearch(let latitude, let longitude, let limit, let categories, let isOpenNow, let sortBy):
            return [APIParameterKey.latitude: latitude, APIParameterKey.longitude: longitude, APIParameterKey.limit: limit, APIParameterKey.categories: categories, APIParameterKey.openNow: isOpenNow, APIParameterKey.sortyBy: sortBy]
        case .businessDetail:
            return [:]
        }
    }
    
    // MARK: - URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        var urlComponents = URLComponents(string: YelpServer.baseURL)
        urlComponents?.path = path
        urlComponents?.queryItems = queryItems

            
        var urlRequest = URLRequest(url: (urlComponents?.url)!)
    
        
        //HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
//        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        urlRequest.setValue(APIKey.key, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        
        return urlRequest
    }
}
