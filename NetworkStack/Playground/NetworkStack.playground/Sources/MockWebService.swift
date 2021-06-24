//
//  MockWebService.swift
//  NetworkStack
//
//  Created by Vignesh J on 24/07/20.
//  Copyright © 2020 Vignesh Jeyaraj. All rights reserved.
//

import Foundation

public class MockWebService: WebServiceProtocol {
    private let parser: Parser
    
    public init(parser: Parser = Parser()) {
        self.parser = parser
    }
    
    public func request<T: Decodable>(_ endpoint: Endpoint, completition: @escaping ResultCallback<T>) {
        
        guard let endpoint = endpoint as? MockEndpoint else {
            OperationQueue.main.addOperation({ completition(.failure(NetworkStackError.endpointNotMocked)) })
            return
        }
        
        guard let data = endpoint.mockData() else {
            OperationQueue.main.addOperation({ completition(.failure(NetworkStackError.mockDataMissing)) })
            return
        }
        
        parser.json(data: data, completition: completition)
    }
    
    public func request<T: Decodable>(_ endpoint: Endpoint, completition: @escaping ResultCallback<T>) -> URLSessionTask? {
        guard let endpoint = endpoint as? MockEndpoint else {
            OperationQueue.main.addOperation({ completition(.failure(NetworkStackError.endpointNotMocked)) })
            return nil
        }
        
        guard (endpoint.mockData()) != nil else {
            OperationQueue.main.addOperation({ completition(.failure(NetworkStackError.mockDataMissing)) })
            return nil
        }
        
        return nil
    }
    
    public func resume(task: URLSessionTask) {
        
    }
}
