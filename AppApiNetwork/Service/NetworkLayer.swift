//
//  NetworkLayer.swift
//  AppApiNetwork
//
//  Created by admin on 01/03/24.
//

import Foundation

protocol NetworkLayer {
//    func request<T: Decodable>(with urlString: String, method: HTTPMethod, decodeType: T.Type, completion: @escaping (Result<T,NetworkError>) -> Void)
    func request3<T>(with endpoint: EndPoint, decodeType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable
}
