// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "SetterOperators",
    products: [
        .library(
            name: "SetterOperators",
            targets: ["SetterOperators"]
        ),
    ],
    targets: [
        .target(name: "SetterOperators"),
        .testTarget(
            name: "SetterOperatorsTests",
            dependencies: ["SetterOperators"]
        )
    ]
)
