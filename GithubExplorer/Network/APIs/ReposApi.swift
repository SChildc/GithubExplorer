//
//  ReposApi.swift
//  GithubExplorer
//
//  Created by childc on 2/18/24.
//

import Foundation

enum ReposApi: BaseApi {
    case repos(owner: String, repo: String)
    
    var domain: String { "repos" }
    var path: String? { nil }
    var method: HTTPMethod { .get }
}
