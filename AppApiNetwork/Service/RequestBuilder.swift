//
//  RequestBuilder.swift
//  AppApiNetwork
//
//  Created by admin on 01/03/24.
//

import Foundation

protocol RequestBuilder {
    func buildRequest(with endpoint: EndPoint, url: URL) -> URLRequest
    
}
