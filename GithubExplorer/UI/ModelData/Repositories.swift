//
//  Repositories.swift
//  GithubExplorer
//
//  Created by childc on 2/18/24.
//

import Foundation
import Combine
import OSLog

private let logger = Logger(subsystem: "GithubExplorer", category: "Repositories")

private enum Const {
    static let searchDebounceTime: TimeInterval = 0.5
}

final class Repositories: ObservableObject {
    @Published var searchText = ""
    @Published var items = [RepositoriesRequest.Response.Items]()
    
    private var fetchTask: Task<Void, Error>?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $searchText.debounce(for: .seconds(Const.searchDebounceTime), scheduler: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: fetch)
            .store(in: &cancellables)
    }
    
    private func fetch(searchText: String) {
        fetchTask?.cancel()
        
        if searchText.isEmpty {
            items.removeAll()
            return
        }
        
        fetchTask = Task {
            do {
                let repos = try await NetworkClient.shared.request(request: RepositoriesRequest(searchText: searchText))
                await MainActor.run {
                    items = repos.items
                }
            } catch {
                logger.debug("fetch error: \(error)")
            }
        }
    }
}
