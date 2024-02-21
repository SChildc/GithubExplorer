import ProjectDescription

let project = Project(
    name: "GithubExplorer",
    packages: [
        .local(path: "Packages/GENetworking")
    ],
    targets: [
        .target(
            name: "GithubExplorer",
            destinations: .iOS,
            product: .app,
            bundleId: "com.schildc.GithubExplorer",
            deploymentTargets: .iOS("16.4"),
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                ]
            ),
            sources: ["GithubExplorer/Sources/**"],
//            resources: ["GithubExplorer/Resources/**"],
            dependencies: [.target(name: "Repositories")]
        ),
        .target(
            name: "Repositories",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.schildc.GithubExplorer.Repositories",
            deploymentTargets: .iOS("16.4"),
            infoPlist: .default,
            sources: ["Targets/Repositories/Sources/**"],
            resources: ["Targets/Repositories/Resources/**"],
            dependencies: [.package(product: "GENetworking", type: .runtime)]
        ),
    ]
)
