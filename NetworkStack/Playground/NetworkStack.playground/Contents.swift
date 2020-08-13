/*: Description
 # NetworkStack
 Clean and simple networking stack
 */
import UIKit
import PlaygroundSupport

// Example

extension Endpoint {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "jsonplaceholder.typicode.com"
    }
}

// UserEndpoint

enum UserEndpoint {
    case all
    case get(userId: Int)
}

extension UserEndpoint: Endpoint {
    
    var request: URLRequest? {
        switch self {
        case .all:
            return request(forEndpoint: "/users")
        case .get(let userId):
            return request(forEndpoint: "/users/\(userId)")
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .all:
            return .get
        case .get( _):
            return .get
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .all:
            return nil
        case .get(let userId):
            return [URLQueryItem(name: "userId", value: String(userId))]
        }
    }
    
    var httpHeaders: [String: String]? {
        let headers: [String: String] = ["headerField" : "headerValue"]
        switch self {
        case .all, .get( _):
            return headers
        }
    }
}

// Mock UserEndpoint

extension UserEndpoint: MockEndpoint {
    var mockFilename: String? {
        switch self {
        case .all:
            return "users"
        case .get( _):
            return "user"
        }
    }
}

// User

struct User: Codable {
    let id: Int
    let username: String
    let email: String
}

// Playground

PlaygroundPage.current.needsIndefiniteExecution = true

// Run

let networkActivity = NetworkActivity()
let webService = WebService(networkActivity: networkActivity)
let mockWebService = MockWebService()

networkActivity.observe { state in
    switch state {
    case .show:
        print("Network activity indicator: SHOW")
    case .hide:
        print("Network activity indicator: HIDE")
    }
}

webService.request(UserEndpoint.all) { (result: Result<[User], NetworkStackError>) in
    switch result {
    case .failure(let error):
        dump(error)
    case .success(let users):
        dump(users)
    }
}

webService.request(UserEndpoint.get(userId: 10)) { (result: Result<User, NetworkStackError>) in
    switch result {
    case .failure(let error):
        dump(error)
    case .success(let users):
        dump(users)
    }
}

mockWebService.request(UserEndpoint.get(userId: 10)) { (result: Result<User, NetworkStackError>) in
    switch result {
    case .failure(let error):
        dump(error)
    case .success(let users):
        dump(users)
    }
}

mockWebService.request(UserEndpoint.all) { (result: Result<[User], NetworkStackError>) in
    switch result {
    case .failure(let error):
        dump(error)
    case .success(let users):
        dump(users)
    }
}
