//
//  Endpoint.swift
//  NetworkStack
//
//  Created by Vignesh J on 24/07/20.
//  Copyright © 2020 Vignesh Jeyaraj. All rights reserved.
//

import Foundation

public protocol Endpoint {
    var request: URLRequest? { get }
    var httpMethod: HTTPMethod { get }
    var httpHeaders: [String : String]? { get }
    var queryItems: [URLQueryItem]? { get }
    var scheme: String { get }
    var host: String { get }
    var port: Int? { get }
    var body: Data? { get }
}

public extension Endpoint {
    func request(forEndpoint endpoint: String) -> URLRequest? {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.port = port
        urlComponents.path = endpoint
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        if let httpHeaders = httpHeaders {
            for (key, value) in httpHeaders {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        request.httpBody = body
        
        return request
    }
}
