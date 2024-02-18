//
//  RepoDetailRequest.swift
//  GithubExplorer
//
//  Created by childc on 2/18/24.
//

import Foundation

struct RepoDetailRequest: NetworkRequestable {
    let api: BaseApi
    
    init(owner: String, name: String) {
        api = ReposApi.repos(owner: owner, repo: name)
    }
    
    struct Response: Decodable {
        let subscribersCount: Int
        
        private enum CodingKeys: String, CodingKey {
            case subscribersCount = "subscribers_count"
        }
    }
}
