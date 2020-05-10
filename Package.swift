// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Backtrace",
    products: [
        .library(name: "Backtrace", targets: ["Backtrace"]),
    ],
    dependencies: [
         .package(url: "https://github.com/mattgallagher/CwlDemangle", from: "0.1.0"),
    ],
    targets: [
        .target(name: "Backtrace", dependencies: ["CwlDemangle"]),
        .testTarget(name: "BacktraceTests", dependencies: ["Backtrace"]),
    ]
)
