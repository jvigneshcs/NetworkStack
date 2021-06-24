//
//  WebServiceProtocol.swift
//  NetworkStack
//
//  Created by Vignesh J on 24/07/20.
//  Copyright © 2020 Vignesh Jeyaraj. All rights reserved.
//

import Foundation

public protocol WebServiceProtocol {
    func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping ResultCallback<T>)
    func task<T: Decodable>(for endpoint: Endpoint, completion: @escaping ResultCallback<T>) -> URLSessionTask?
    func resume(task: URLSessionTask)
}
