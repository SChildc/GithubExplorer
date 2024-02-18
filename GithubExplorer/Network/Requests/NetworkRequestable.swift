//
//  NetworkRequestable.swift
//  GithubExplorer
//
//  Created by childc on 2/18/24.
//

import Foundation

/// `NetworkClient`에 전달할 request
protocol NetworkRequestable {
    /// Request에 대한 응답 모델
    associatedtype Response: Decodable
    
    /// Request가 사용할 API
    var api: BaseApi { get }
}
