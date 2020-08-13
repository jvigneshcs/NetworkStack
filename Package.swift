// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "NetworkStack",
    platforms: [
        .macOS(.v10_11),
        .iOS(.v9),
        .tvOS(.v9),
        .watchOS(.v3)
    ],
    products: [
        .library(
            name: "NetworkStack",
            targets: ["NetworkStack"]),
    ],    
    targets: [
        .target(
            name: "NetworkStack",
            path: "NetworkStack/Playground/NetworkStack.playground/Sources"          
            ),
    ],
    swiftLanguageVersions: [.v4_2]
)
