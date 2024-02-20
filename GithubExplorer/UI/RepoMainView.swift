//
//  RepoSearchView.swift
//  GithubExplorer
//
//  Created by childc on 2/18/24.
//

import SwiftUI

private enum Const {
    static let titleTextSize: CGFloat = 17
    static let titleTextHeight: CGFloat = 22
    static let subtitleTextSize: CGFloat = 15
    static let subtitleTextHeight: CGFloat = 20
    static let subtitleTextColor = "#3C3C43"
    static let titleAndCountsGap: CGFloat = 4
    static let countsGap: CGFloat = 2
}

struct RepoMainView: View {
    @StateObject private var repositories = Repositories()
    
    var body: some View {
        NavigationStack {
            VStack {
                Divider()
                
                List {
                    ForEach(repositories.items) { item in
                        NavigationLink {
                            RepoDetailView(
                                name: item.fullName,
                                description: item.description ?? "",
                                owner: item.owner,
                                forksCount: item.forksCount ?? .zero,
                                stargazersCount: item.stargazersCount ?? .zero)
                        } label: {
                            RepositoryInfoView(item: item)
                        }

                    }
                }
                .listStyle(.plain)
                
                Spacer()
            }
            .navigationTitle(Text("Repository"))
        }
        .searchable(text: $repositories.searchText)
    }
}

// MARK: - Internal Views

private extension RepoMainView {
    struct RepositoryInfoView: View {
        let item: RepositoriesRequest.Response.Items
        
        var body: some View {
            VStack(alignment: .leading, spacing: Const.titleAndCountsGap) {
                VStack(alignment: .leading, spacing: .zero) {
                    Text(item.fullName)
                        .font(fontSize: Const.titleTextSize, lineHeight: Const.titleTextHeight)
                    
                    Text(formattedDescription)
                        .foregroundColor(Color(hex: Const.subtitleTextColor))
                        .font(fontSize: Const.subtitleTextSize, lineHeight: Const.subtitleTextHeight)
                }
                
                HStack(spacing: Const.countsGap) {
                    CountInfoView(type: .forks, count: item.forksCount ?? .zero)
                    CountInfoView(type: .stargazers, count: item.stargazersCount ?? .zero)
                }
            }
        }
        
        var formattedDescription: String {
            var desc = item.description ?? ""
            
            if desc.isEmpty == false {
                desc += " "
            }
            
            desc += "by \(item.owner)"
            return desc
        }
    }
}

// MARK: - View convinience

extension RepositoriesRequest.Response.Items: Identifiable {}

#Preview {
    RepoMainView()
}
