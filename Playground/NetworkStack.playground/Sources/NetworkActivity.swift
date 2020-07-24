//
//  NetworkActivity.swift
//  NetworkStack
//
//  Created by Vignesh J on 24/07/20.
//  Copyright © 2020 Vignesh Jeyaraj. All rights reserved.
//

import Foundation

public class NetworkActivity: NetworkActivityProtocol {
    private var observations = [(NetworkActivityState) -> Void]()
    
    private var activityCount: Int = 0 {
        didSet {
            
            if (activityCount < 0) {
                activityCount = 0
            }
            
            if (oldValue > 0 && activityCount > 0) {
                return
            }
            
            stateDidChange()
        }
    }
    
    public init() {
        
    }
    
    private func stateDidChange() {
        
        let state = activityCount > 0 ? NetworkActivityState.show : NetworkActivityState.hide
        observations.forEach { closure in
             OperationQueue.main.addOperation({ closure(state) })
        }
    }
    
    public func increment() {
        self.activityCount += 1
    }
    
    public func decrement() {
        self.activityCount -= 1
    }
    
    public func observe(using closure: @escaping (NetworkActivityState) -> Void) {
        observations.append(closure)
    }
}
