//
//  GithubExplorerApp.swift
//  GithubExplorer
//
//  Created by childc on 2/18/24.
//

import SwiftUI

@main
struct GithubExplorerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            RepoMainView()
        }
    }
}
