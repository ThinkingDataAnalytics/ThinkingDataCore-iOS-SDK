// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ThinkingDataCore",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "ThinkingDataCore",
            targets: ["ThinkingDataCore"])
    ],
    targets: [
        .target(
            name: "ThinkingDataCore",
            dependencies: [],
            path: "ThinkingDataCore",
            resources: [.copy("Resources/PrivacyInfo.xcprivacy")],
            // Keep quoted imports (`#import "Foo.h"`) working after nesting
            // public headers under include/ThinkingDataCore/.
            cSettings: [
                .headerSearchPath("include/ThinkingDataCore")
            ]
        )
    ]
)
