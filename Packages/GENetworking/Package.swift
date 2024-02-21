// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "GENetworking",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "GENetworking",
            targets: ["GENetworking"]
        ),
    ],
    targets: [
        .target(
            name: "GENetworking"
        ),
    ]
)
