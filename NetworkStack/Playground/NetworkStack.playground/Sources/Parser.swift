//
//  Parser.swift
//  NetworkStack
//
//  Created by Vignesh J on 24/07/20.
//  Copyright © 2020 Vignesh Jeyaraj. All rights reserved.
//

import Foundation

public struct Parser: ParserProtocol {
    public let jsonDecoder = JSONDecoder()
    
    public init() {
        
    }
    
    public func json<T: Decodable>(data: Data, urlResponse: URLResponse?, completion: @escaping ResultCallback<T>) {
        do {
            let result: T = try jsonDecoder.decode(T.self, from: data)
            OperationQueue.main.addOperation { completion(.success(result)) }
            
        } catch let error {
            OperationQueue.main.addOperation { completion(.failure(.parserError(error: error, data: data, urlResponse: urlResponse))) }
        }
    }
}
