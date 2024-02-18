//
//  NetworkClient.swift
//  GithubExplorer
//
//  Created by childc on 2/18/24.
//

import Foundation
import OSLog

private let logger = Logger(subsystem: "GithubExplorer", category: "Network")

final class NetworkClient {
    static let shared = NetworkClient()
    
    // cache, cookie or credential에 대해 persistent storage를 사용하지 않기 위해 ephemeral로 설정한다.
    private let urlSession = URLSession(configuration: .ephemeral)
    
    func request<Request: NetworkRequestable>(request: Request) async throws -> Request.Response {
        guard let urlRequest = request.api.urlRequest else { throw NetworkClientError.invaildRequest }
        logger.debug("url request: \(urlRequest)")
        
        let (data, urlResponse) = try await urlSession.data(for: urlRequest)
        guard let httpResponse = urlResponse as? HTTPURLResponse else { throw NetworkClientError.unknownRespose(urlResponse) }
        
        // TODO: Status 처리
        // token refresh등 처리해야할 일이 많지만 과제 범위 밖이므로 일단은 OK만 처리하고, 나머지는 error리포트로 대체한다
        switch httpResponse.statusCode {
        case HTTPStatusCode.ok.rawValue:
//            logger.debug("recv data: \(String(data: data, encoding: .ascii) ?? "<< cannot convert to string >>")")
            break
        default:
            throw NetworkClientError.httpResponseError(httpResponse.statusCode)
        }
        
        let response = try JSONDecoder().decode(Request.Response.self, from: data)
        return response
    }
}

enum NetworkClientError: Error {
    case invaildRequest
    case unknownRespose(_ response: URLResponse)
    case httpResponseError(_ code: Int)
}
