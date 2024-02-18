//
//  RepoSearchView.swift
//  GithubExplorer
//
//  Created by childc on 2/18/24.
//

import SwiftUI

struct RepoSearchView: View {
    @StateObject private var repositories = Repositories()
    
    var body: some View {
        NavigationStack {
            VStack {
                Divider()
                
                List {
                    ForEach(repositories.items, content: RepositoryInfoView.init)
                }
                
                Spacer()
            }
            .navigationTitle(Text("Repository"))
        }
        .searchable(text: $repositories.searchText)
    }
}

// MARK: - Internal Views

private extension RepoSearchView {
    struct RepositoryInfoView: View {
        let item: RepositoriesRequest.Response.Items
        
        var body: some View {
            VStack(alignment: .leading) {
                Text(item.fullName)
                Text("\(item.description ?? "") by \(item.owner)")
                HStack {
                    Text("\(item.forksCount ?? .zero)")
                    Text("\(item.stargazersCount ?? .zero)")
                }
            }
        }
    }
}

// MARK: - View convinience

extension RepositoriesRequest.Response.Items: Identifiable {}

#Preview {
    RepoSearchView()
}
