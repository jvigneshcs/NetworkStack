//
//  WebService.swift
//  NetworkStack
//
//  Created by Vignesh J on 24/07/20.
//  Copyright © 2020 Vignesh Jeyaraj. All rights reserved.
//

import Foundation

public class WebService: WebServiceProtocol {
    private let urlSession: URLSession
    private let parser: Parser
    private let networkActivity: NetworkActivityProtocol
    
    /// Initializer
    /// - Parameters:
    ///   - urlSession: URLSession
    ///   - parser: Parser
    ///   - networkActivity: NerworkActivityProtocol
    public init(urlSession: URLSession = URLSession(configuration: URLSessionConfiguration.default),
                parser: Parser = Parser(),
                networkActivity: NetworkActivityProtocol = NetworkActivity()) {
        self.urlSession = urlSession
        self.parser = parser
        self.networkActivity = networkActivity
    }
    
    /// Request with Endpoint
    /// - Parameters:
    ///   - endpoint: Endpoint
    ///   - completition: ResultCallback
    public func request<T: Decodable>(_ endpoint: Endpoint, completition: @escaping ResultCallback<T>) {
        
        guard let task = self.task(for: endpoint,
                                   completition: completition) else {
            return
        }
        
        self.resume(task: task)
    }
    
    /// Task for Endpoint, calling URLSessionTask's resume function is caller's responsibility
    /// - Parameters:
    ///   - for: Endpoint
    ///   - completition: ResultCallback
    /// - Returns: URLSessionTask
    public func task<T: Decodable>(for endpoint: Endpoint, completition: @escaping ResultCallback<T>) -> URLSessionTask? {
        
        guard let request = endpoint.request else {
            OperationQueue.main.addOperation({ completition(.failure(NetworkStackError.invalidRequest)) })
            return nil
        }
        
        let task = urlSession.dataTask(with: request) { [unowned self] (data, response, error) in
            
            self.networkActivity.decrement()
            
            if let error = error {
                OperationQueue.main.addOperation({ completition(.failure(.responseError(error: error))) })
                return
            }
            
            guard let data = data else {
                OperationQueue.main.addOperation({ completition(.failure(NetworkStackError.dataMissing)) })
                return
            }
            
            self.parser.json(data: data, urlResponse: response, completition: completition)
        }
        
        return task
    }
    
    /// Resume the URLSessionTask
    /// - Parameter task: URLSessionTask
    public func resume(task: URLSessionTask) {
        self.networkActivity.increment()
        task.resume()
    }
}
