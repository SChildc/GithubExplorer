//
//  AutoLineFeedView.swift
//  GithubExplorer
//
//  Created by childc on 2/20/24.
//

import SwiftUI

private enum Const {
        static let tagSpacing: CGFloat = 5
    }

struct AutoLineFeedView: View {
    let tags = ["asfd", "asldfijilsajdfli", "asldifliasjdf", "asldfijliasdjfliasjdflijaf"]
    
    var body: some View {
        GeometryReader { geometry in
            var width = CGFloat.zero
            var height = CGFloat.zero
            
            ZStack(alignment: .topLeading) {
                ForEach(tags, id: \.self) { tag in
                    Text(tag)
                        .lineLimit(1)
                        .alignmentGuide(.leading) { tagSize in
                            if abs(width - (tagSize.width + Const.tagSpacing)) > geometry.size.width {
                                width = 0
                                height -= tagSize.height
                            }
                            let result = width
                            if tag == tags.last ?? "" {
                                width = 0
                            } else {
                                width -= (tagSize.width + Const.tagSpacing)
                            }
                            return result
                        }
                        .alignmentGuide(.top) { _ in
                            let result = height
                            if tag == tags.last ?? "" {
                                height = 0
                            }
                            return result
                        }
                }
            }
        }
        
       
    }
}

#Preview {
    AutoLineFeedView()
}
