//
//  NetworkActivityProtocol.swift
//  NetworkStack
//
//  Created by Vignesh J on 24/07/20.
//  Copyright © 2020 Vignesh Jeyaraj. All rights reserved.
//

import Foundation

public protocol NetworkActivityProtocol {
    func increment()
    func decrement()
    func observe(using closure: @escaping (NetworkActivityState) -> Void)
}
