// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "NetworkStack",
    platforms: [
        .iOS(.v9),
    ],
    products: [
        .library(
            name: "NetworkStack",
            targets: ["NetworkStack"]),
    ],    
    targets: [
        .target(
            name: "NetworkStack",
            path: "NetworkStack"          
            ),
    ],
    swiftLanguageVersions: [.v4_2]
)
