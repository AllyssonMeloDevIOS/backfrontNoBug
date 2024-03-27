//
//  DefaultRequestBuilder.swift
//  AppApiNetwork
//
//  Created by admin on 01/03/24.
//

import Foundation

class DefaultRequestBuilder: RequestBuilder {
    func buildRequest(with endpoint: EndPoint, url: URL) -> URLRequest {
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        
        if let parameters = endpoint.parameters {
            switch parameters {
            case .dictionary(let dictionary):
                request.httpBody = try? JSONSerialization.data(withJSONObject: dictionary, options: .fragmentsAllowed)
            case .encodable(let encodable):
                request.httpBody = try? JSONEncoder().encode(encodable)
            }
        }
     return request
    }
}
