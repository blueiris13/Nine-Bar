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
        case .businessSearch(let latitude, let longitude, let limit, let categories):
            return "/businesses/search?&latitude=\(latitude)&longitude=\(longitude)&limit=\(limit)&categories=\(categories)"
            
        case .businessDetail(let businessID):
            return "/businesses/search/\(businessID)"
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
        let url = try YelpServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
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
