//
//  RepoDetail.swift
//  GithubExplorer
//
//  Created by childc on 2/18/24.
//

import Foundation
import OSLog

private let logger = Logger(subsystem: "GitExplorer", category: "RepoDetail")

final class RepoDetail: ObservableObject {
    @Published var subscribersCount: Int?
    
    func fetch(owner: String, name: String) {
        Task {
            do {
                let detail = try await NetworkClient.shared.request(request: RepoDetailRequest(owner: owner, name: name))
                
                await MainActor.run {
                    subscribersCount = detail.subscribersCount
                }
            } catch {
                logger.debug("fetch error: \(error)")
            }
        }
    }
}
