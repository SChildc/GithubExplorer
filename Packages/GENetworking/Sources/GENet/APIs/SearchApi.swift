//
//  SearchApi.swift
//
//
//  Created by childc on 2/18/24.
//

import Foundation

/// `Search`에 관한 API
enum SearchApi: BaseApi {
    case repositories(searchText: String)
    
    var domain: String { "search" }
    var path: String? { "repositories" }
    var method: HTTPMethod { .get }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case let .repositories(searchText):
            return [.init(name: "q", value: searchText)]
        }
    }
 }
