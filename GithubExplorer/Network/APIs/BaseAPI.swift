//
//  BaseAPI.swift
//
//
//  Created by childc on 2/18/24.
//

import Foundation

protocol BaseApi {
    /// Base URL
    var baseURL: String { get }
    
    /// Base URL 이후 공통으로 사용되는 path의 요소
    var domain: String { get }
    
    /// API path
    var path: String? { get }
    
    /// HTTP method
    var method: HTTPMethod { get }
    
    /// API에서 필요로하는 Query parameter
    var queryItems: [URLQueryItem]? { get }
    
    /// Common header 이외에 API에서 추가적으로 사용하는 헤더정보
    var additionalHeader: [String: String]? { get }
    
    /// API에서 필요로하는 body
    var body: [String: Any]? { get }
    
    /// API에서 필요로하는 Multipart body
    var multipartBody: Data? { get }
    
    /// Request timeout 설정
    var timeOut: TimeInterval { get }
}

extension BaseApi {
    var baseURL: String {
        return "https://api.github.com"
    }
    
    var url: String {
        return [baseURL, domain, path]
            .compactMap { $0 }
            .filter { $0.isEmpty == false }
            .joined(separator: "/")
    }

    var additionalHeader: [String: String]? {
        return nil
    }
    
    var method: HTTPMethod {
        return .get
    }

    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    /// Common header와 additionalHeader를 merge한 최종 header
    var header: [String: String]? {
        // 본 프로젝트에서는 common header가 없으므로 additionalHeader만 반환한다.
        return additionalHeader
    }

    var body: [String: Any]? {
        return nil
    }
    
    var multipartBody: Data? {
        return nil
    }

    var timeOut: TimeInterval {
        // 네트워크 약전계를 고려하여 30sec.로 넉넉하게 잡는다.
        return 30
    }
}

extension BaseApi {
    /// 제공된 정보로 생성한 `URLRequest`
    var urlRequest: URLRequest? {
        guard var urlComponents = URLComponents(string: url) else { return nil }
        if let queryItems = queryItems {
            urlComponents.queryItems = queryItems
        }

        guard let url = urlComponents.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = header
        request.timeoutInterval = timeOut

        if let body = body,
           let bodyData = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted) {
            request.httpBody = bodyData
        }

        if let multipartBody = multipartBody {
            request.httpBody = multipartBody
        }

        return request
    }
}
