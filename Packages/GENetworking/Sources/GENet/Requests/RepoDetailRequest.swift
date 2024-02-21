//
//  RepoDetailRequest.swift
//  GithubExplorer
//
//  Created by childc on 2/18/24.
//

import Foundation

public struct RepoDetailRequest: NetworkRequestable {
    public let api: BaseApi
    
    public init(owner: String, name: String) {
        api = ReposApi.repos(name: name)
    }
    
    public struct Response: Decodable {
        public let subscribersCount: Int
        
        private enum CodingKeys: String, CodingKey {
            case subscribersCount = "subscribers_count"
        }
    }
}
