//
//  MockEndPoint.swift
//  NetworkStack
//
//  Created by Vignesh J on 24/07/20.
//  Copyright © 2020 Vignesh Jeyaraj. All rights reserved.
//

import Foundation

public protocol MockEndpoint: Endpoint {
    var mockFilename: String? { get }
    var mockExtension: String? { get }
}

public extension MockEndpoint {
    func mockData() -> Data? {
        guard let mockFileUrl = Bundle.main.url(forResource: mockFilename, withExtension: mockExtension),
            let mockData = try? Data(contentsOf: mockFileUrl) else {
                return nil
        }
        return mockData
    }
}

public extension MockEndpoint {
    var mockExtension: String? {
        return "json"
    }
}
