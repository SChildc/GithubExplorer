//
//  RepoDetailView.swift
//  GithubExplorer
//
//  Created by childc on 2/18/24.
//

import SwiftUI

private enum Const {
    // Content
    static let contentHorizontalPadding: CGFloat = 16
    
    // Description
    static let descriptionTextSize: CGFloat = 16
    static let descriptionTextHeight: CGFloat = 21
    
    // Gaps
    static let titleAndCountsGap: CGFloat = 4
    static let countsGap: CGFloat = 2
}

struct RepoDetailView: View {
    let name: String
    let description: String
    let owner: String
    let forksCount: Int
    let stargazersCount: Int
    
    @StateObject private var repoDetail = RepoDetail()
    
    var body: some View {
        VStack(alignment: .leading, spacing: Const.titleAndCountsGap) {
            Divider()
            
            Text("\(description) by \(owner)")
                .font(fontSize: Const.descriptionTextSize, lineHeight: Const.descriptionTextHeight)
            
            HStack(spacing: Const.countsGap) {
                CountInfoView(type: .forks, count: forksCount)
                CountInfoView(type: .stargazers, count: stargazersCount)
                if let subscribersCount = repoDetail.subscribersCount {
                    CountInfoView(type: .subscribers, count: subscribersCount)
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, Const.contentHorizontalPadding)
        .task {
            repoDetail.fetch(owner: owner, name: name)
        }
        .navigationTitle(Text(name))
    }
}

#Preview {
    RepoDetailView(name: "Name", description: "Desc", owner: "Owner", forksCount: 1, stargazersCount: 10)
}
