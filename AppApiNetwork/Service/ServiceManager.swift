//
//  ServiceManager.swift
//  AppApiNetwork
//
//  Created by admin on 25/02/24.
//

import Foundation

class ServiceManager: NetworkLayer {
    
    static var shared: ServiceManager = ServiceManager()
    
    private var baseURL: String
    private var requestBuilder: RequestBuilder
    private var session: URLSession
    private var decoder: JSONDecoder
    
    //    init(baseURL: String? = nil) {
    //
    //        if let baseURL {
    //            self.baseURL = baseURL
    //        } else if let baseURLString = Bundle.main.infoDictionary?["BaseURL"] as? String {
    //            self.baseURL = baseURLString
    //        } else {
    //            self.baseURL = ""
    //        }
    //    }
    init(session: URLSession = URLSession.shared, baseURL: String? = nil, requestBuilder: RequestBuilder = DefaultRequestBuilder(), decoder: JSONDecoder = JSONDecoder()) {
        self.requestBuilder = requestBuilder
        self.session = session
        self.decoder = decoder
        
        if let baseURL {
            self.baseURL = baseURL
        } else if let baseURLString = Bundle.main.infoDictionary?["BaseURL"] as? String {
            self.baseURL = baseURLString
        } else {
            self.baseURL = ""
        }
    }
    
    func request<T>(with endpoint: EndPoint, decodeType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        
        let urlString = baseURL + endpoint.url
        
        guard let url: URL = URL(string: urlString) else {
            completion(.failure(.invalidURL(url: urlString)))
            return
        }
        
        let request = requestBuilder.buildRequest(with: endpoint, url: url)
        
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error {
                    print("ERROR \(#function) Detalhe do erro: \(error.localizedDescription)")
                    completion(.failure(.networkFailure(error)))
                    return
                }
                
                guard let data else {
                    completion(.failure(.noData))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode  else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let object: T = try decoder.decode(T.self, from: data)
                    print("SUCCESS -> \(#function)")
                    completion(.success(object))
                } catch  {
                    print("ERROR -> \(#function)")
                    completion(.failure(NetworkError.decodingError(error)))
                }
            }
        }
        task.resume()
    }
    
    func request2<T>(with endpoint: EndPoint, decodeType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        
        let urlString = baseURL + endpoint.url
        guard let url: URL = URL(string: urlString) else {
            completion(.failure(.invalidURL(url: urlString)))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error {
                    print("ERROR \(#function) Detalhe do erro: \(error.localizedDescription)")
                    completion(.failure(.networkFailure(error)))
                    return
                }
                
                guard let data else {
                    completion(.failure(.noData))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode  else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let object: T = try decoder.decode(T.self, from: data)
                    print("SUCCESS -> \(#function)")
                    completion(.success(object))
                } catch  {
                    print("ERROR -> \(#function)")
                    completion(.failure(NetworkError.decodingError(error)))
                }
            }
        }
        task.resume()
    }
    
    func request3<T>(with endpoint: EndPoint, decodeType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        
        let urlString = baseURL + endpoint.url
        guard let url: URL = URL(string: urlString) else {
            NetworkLogger.logError(error: .invalidURL(url: urlString))
            completion(.failure(.invalidURL(url: urlString)))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        let task = session.dataTask(with: request) { data, response, error in
            NetworkLogger.log(request: request, response: response, data: data, error: error)
            DispatchQueue.main.async {
                if let error {
                    completion(.failure(.networkFailure(error)))
                    return
                }
                
                guard let data else {
                    completion(.failure(.noData))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode  else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                do {
                    let object: T = try self.decoder.decode(T.self, from: data)
                    completion(.success(object))
                } catch  {
                    completion(.failure(NetworkError.decodingError(error)))
                }
            }
        }
        task.resume()
    }
    
}
