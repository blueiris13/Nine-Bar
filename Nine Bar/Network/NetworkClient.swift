//
//  NetworkClient.swift
//  Nine Bar
//
//  Created by Hyun Kim
//

import Foundation
import Alamofire
class NetworkClient{
    static func getSearchResults(latitude: Double, longitude: Double, completion: @escaping (Result<SearchResponse, AFError>) -> Void) {
        AF.request(APIRouter.businessSearch(latitude: latitude, longitude: longitude, limit: APIParameterValue.limit, categories: APIParameterValue.categories, openNow: APIParameterValue.isOpenNow, sortBy: APIParameterValue.sortBy)).responseDecodable {
            (response: DataResponse<SearchResponse, AFError>) in
            print(response.result)
            completion(response.result)
        }
    }
}
