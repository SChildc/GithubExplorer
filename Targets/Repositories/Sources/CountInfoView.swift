//
//  CountInfoView.swift
//  GithubExplorer
//
//  Created by childc on 2/20/24.
//

import SwiftUI

private enum Const {
    static let countPadding: CGFloat = 4
    static let countGap: CGFloat = 2
    static let countRadius: CGFloat = 4
    static let countIconSize: CGSize = CGSize(width: 16, height: 16)
    static let countTextFontSize: CGFloat = 12
    static let countTextHeight: CGFloat = 16
}

struct CountInfoView: View {
    let type: CountInfoType
    let count: Int?
    
    var body: some View {
        HStack(spacing: Const.countGap) {
            Image(type.icon, bundle: .module)
                .frame(width: Const.countIconSize.width, height: Const.countIconSize.height)
            
            if let count {
                Text("\(count)")
                    .foregroundColor(.white)
                    .font(.system(size: Const.countTextFontSize))
                    .frame(height: Const.countTextHeight)
            } else {
                ProgressView()
                    .frame(width: Const.countTextHeight, height: Const.countTextHeight)
            }
        }
        .padding(Const.countPadding)
        .background(
            RoundedRectangle(cornerRadius: Const.countRadius)
                .foregroundColor(Color(hex: type.bgHecColor))
            
        )
    }
}

extension CountInfoView {
    enum CountInfoType {
        case forks
        case stargazers
        case subscribers
        
        var icon: String {
            switch self {
            case .forks:
                return "forks"
            case .stargazers:
                return "stargazers"
            case .subscribers:
                return "subscribers"
            }
        }
        
        var bgHecColor: String {
            switch self {
            case .forks:
                return "#FF9500"
            case .stargazers:
                return "#30B0C7"
            case .subscribers:
                return "#FF2D55"
            }
        }
    }
}

#Preview {
    CountInfoView(type: .forks, count: 1000)
}
