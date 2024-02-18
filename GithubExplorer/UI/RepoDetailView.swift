//
//  RepoDetailView.swift
//  GithubExplorer
//
//  Created by childc on 2/18/24.
//

import SwiftUI

struct RepoDetailView: View {
    let name: String
    let description: String
    let owner: String
    let forksCount: Int
    let stargazersCount: Int
    
    @StateObject private var repoDetail = RepoDetail()
    
    var body: some View {
        VStack(spacing: .zero) {
            Text(name)
            Text("\(description) by \(owner)")
            
            HStack {
                Text("\(forksCount)")
                Text("\(stargazersCount)")
                Text("\(repoDetail.subscribersCount)")
            }
        }
        .task {
            repoDetail.fetch(owner: owner, name: name)
        }
    }
}

#Preview {
    RepoDetailView(name: "Name", description: "Desc", owner: "Owner", forksCount: 1, stargazersCount: 10)
}
