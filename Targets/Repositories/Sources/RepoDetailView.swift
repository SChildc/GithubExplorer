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
    
    @State private var countInfos: [CountInfo]
    @StateObject private var repoDetail = RepoDetail()
    
    init(name: String, description: String, owner: String, forksCount: Int, stargazersCount: Int) {
        self.name = name
        self.description = description
        self.owner = owner
        self.forksCount = forksCount
        self.stargazersCount = stargazersCount
        
        _countInfos = State<[CountInfo]>(initialValue: [
//            .init(type: .forks, count: forksCount),
//            .init(type: .stargazers, count: stargazersCount),
//            .init(type: .forks, count: forksCount),
//            .init(type: .stargazers, count: stargazersCount),
            .init(type: .forks, count: forksCount),
            .init(type: .stargazers, count: stargazersCount)
        ])
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: Const.titleAndCountsGap) {
            Divider()
            
            Text("\(description) by \(owner)")
                .font(fontSize: Const.descriptionTextSize, lineHeight: Const.descriptionTextHeight)
            
            AutoLineFeedCountInfoView(infos: countInfos)
            
            Spacer()
        }
        .padding(.horizontal, Const.contentHorizontalPadding)
        .task {
            countInfos.append(.init(type: .subscribers, count: nil))
            repoDetail.fetch(owner: owner, name: name)
        }
        .navigationTitle(Text(name))
        .onChange(of: repoDetail.subscribersCount) { newValue in
            if let subscribersCount = newValue {
                countInfos.removeLast()
                countInfos.append(.init(type: .subscribers, count: subscribersCount))
            }
        }
    }
}

extension RepoDetailView {
    struct CountInfo: Identifiable, Equatable {
        let id = UUID().uuidString
        let type: CountInfoView.CountInfoType
        let count: Int?
    }
    
    struct AutoLineFeedCountInfoView: View {
        let infos: [CountInfo]
        @State private var totalHeight: CGFloat = .zero
        
        var body: some View {
            Group {
                GeometryReader { geometry in
                    generateContent(in: geometry)
                }
            }
            .frame(height: totalHeight)
        }
        
        private func generateContent(in geometry: GeometryProxy) -> some View {
            var width = CGFloat.zero
            var height = CGFloat.zero
            
            return ZStack(alignment: .topLeading) {
                ForEach(infos) { info in
                    CountInfoView(type: info.type, count: info.count)
                        .alignmentGuide(.leading) { viewDimension in
                            if abs(width - (viewDimension.width + Const.countsGap)) > geometry.size.width {
                                width = .zero
                                height -= (viewDimension.height + Const.countsGap)
                            }
                            
                            let result = width
                            width = (info == infos.last) ? .zero : width - (viewDimension.width + Const.countsGap)
                            
                            return result
                        }
                        .alignmentGuide(.top) { _ in
                            let result = height
                            height = (info == infos.last) ? .zero : height
                            
                            return result
                        }
                }
            }
        }
    }
}

#Preview {
    RepoDetailView(name: "Name", description: "Desc", owner: "Owner", forksCount: 100000000, stargazersCount: 1000000)
}
