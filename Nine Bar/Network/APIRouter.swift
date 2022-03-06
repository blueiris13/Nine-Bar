//
//  APIRouter.swift
//  Nine Bar
//
//  Created by Hyun Kim
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case businessSearch(latitude: Double, longitude: Double, limit: Int, categories: String)
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
            return "/businesses/\(id)"
        }
        
    }
    
    private var queryItems: [URLQueryItem] {
        switch self {
        case .businessSearch(let latitude, let longitude, let limit, let categories):
            return [
                URLQueryItem(name: APIParameterKey.latitude, value: "\(latitude)"),
                URLQueryItem(name: APIParameterKey.longitude, value: "\(longitude)"),
                URLQueryItem(name: APIParameterKey.limit, value: "\(limit)"),
                URLQueryItem(name: APIParameterKey.categories, value: "\(categories)")
            ]
            
        case .businessDetail(let businessID):
            return [
                // TODO: /businesses/{id} this is a new endpoint, not parameter.
                URLQueryItem(name: "businessID", value: businessID)
            ]
        }
    }
    
    // MARK: - Parameters
    
    private var parameters: Parameters? {
        switch self {
        case .businessSearch(let latitude, let longitude, let limit, let categories):
            return [APIParameterKey.latitude: latitude, APIParameterKey.longitude: longitude, APIParameterKey.limit: limit, APIParameterKey.categories: categories]
        case .businessDetail(let businessID):
            return [APIParameterKey.businessID: businessID]
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
        
        // Parameters
//        if let parameters = parameters {
//            do {
//                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
//            } catch {
//                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
//            }
//        }
        return urlRequest
    }
}
