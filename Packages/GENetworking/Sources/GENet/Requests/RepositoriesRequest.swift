//
//  RepositoriesRequest.swift
//  GithubExplorer
//
//  Created by childc on 2/18/24.
//

import Foundation

public struct RepositoriesRequest: NetworkRequestable {
    public let api: BaseApi
    
    public init(searchText: String) {
        api = SearchApi.repositories(searchText: searchText)
    }
    
    public struct Response: Decodable {
        public let items: [Items]
        
        public struct Items: Decodable {
            public let id: Int
            public let fullName: String
            public let description: String?
            public let owner: String
            public let forksCount: Int?
            public let stargazersCount: Int?
            
            private enum CodingKeys: String, CodingKey {
                case id
                case fullName = "full_name"
                case description
                case owner
                case forksCount = "forks_count"
                case stargazersCount = "stargazers_count"
            }
            
            public init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                id = try container.decode(Int.self, forKey: .id)
                fullName = try container.decode(String.self, forKey: .fullName)
                description = try container.decodeIfPresent(String.self, forKey: .description)
                forksCount = try container.decodeIfPresent(Int.self, forKey: .forksCount)
                stargazersCount = try container.decodeIfPresent(Int.self, forKey: .stargazersCount)
                let owner = try container.decode(Owner.self, forKey: .owner)
                self.owner = owner.login
            }
            
            private struct Owner: Decodable {
                let login: String
            }
        }
    }
}
