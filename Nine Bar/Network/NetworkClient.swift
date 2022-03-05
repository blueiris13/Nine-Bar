//
//  NetworkClient.swift
//  Nine Bar
//
//  Created by Hyun Kim
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case businessSearch(searchText: String)
    case businessDetail
    
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
        case .businessSearch(let searchText):
            return "/businesses/search"
        }
    }
    
    
    func asURLRequest() throws -> URLRequest {
        <#code#>
    }
    
    
    
    
    
}
