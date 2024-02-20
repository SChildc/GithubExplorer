//
//  ReposApi.swift
//  GithubExplorer
//
//  Created by childc on 2/18/24.
//

import Foundation

enum ReposApi: BaseApi {
    case repos(name: String)
    
    var domain: String { "repos" }
    var method: HTTPMethod { .get }
    var path: String? {
        switch self {
        case let .repos(repo):
            return "\(repo)"
        }
    }
}
