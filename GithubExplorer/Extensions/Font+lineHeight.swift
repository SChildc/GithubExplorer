//
//  Font+lineHeight.swift
//  GithubExplorer
//
//  Created by childc on 2/20/24.
//

import SwiftUI

extension Text {
    func font(fontSize: CGFloat, lineHeight: CGFloat) -> some View {
        let spacing = (lineHeight - fontSize) * 2
        return self
            .font(.system(size: fontSize))
            .lineSpacing(spacing)
            .padding(.vertical, spacing / 2)
    }
}
