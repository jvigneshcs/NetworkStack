//
//  ParserProtocol.swift
//  NetworkStack
//
//  Created by Vignesh J on 24/07/20.
//  Copyright © 2020 Vignesh Jeyaraj. All rights reserved.
//

import Foundation

public protocol ParserProtocol {
    func json<T: Decodable>(data: Data, urlResponse: URLResponse?, completion: @escaping ResultCallback<T>)
}
