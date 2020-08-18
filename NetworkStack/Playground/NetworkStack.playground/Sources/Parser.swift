//
//  Parser.swift
//  NetworkStack
//
//  Created by Vignesh J on 24/07/20.
//  Copyright © 2020 Vignesh Jeyaraj. All rights reserved.
//

import Foundation

public struct Parser {
    public let jsonDecoder = JSONDecoder()
    
    public init() {
        
    }
    
    public func json<T: Decodable>(data: Data, urlResponse: URLResponse? = nil, completition: @escaping ResultCallback<T>) {
        do {
            let result: T = try jsonDecoder.decode(T.self, from: data)
            OperationQueue.main.addOperation { completition(.success(result)) }
            
        } catch let error {
            OperationQueue.main.addOperation { completition(.failure(.parserError(error: error, data: data, urlResponse: urlResponse))) }
        }
    }
}
