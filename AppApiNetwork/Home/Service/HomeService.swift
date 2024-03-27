//
//  HomeService.swift
//  AppApiNetwork
//
//  Created by admin on 24/02/24.
//

import UIKit

class HomeService: NSObject {
    
    func getPersonList(completion: @escaping (Result<[Person],NetworkError>) -> Void) {
//        let urlString: String = "https://run.mocky.io/v3/06e0a58e-acac-41d4-8a5a-6e6be756364c"
        let urlString: String = "06e0a58e-acac-41d4-8a5a-6e6be756364c"
//        ServiceManager.shared.request(with: urlString, method: .get, decodeType: PersonList.self) { result in
        
        let endpoint = EndPoint(url: urlString)
        ServiceManager.shared.request3(with: endpoint, decodeType: PersonList.self) { result in
            switch result {
            case .success(let success):
                completion(.success(success.person))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
        
//            func getPersonList(completion: @escaping (Result<PersonList,NetworkError>) -> Void) {
//                let urlString: String = "https://run.mocky.io/v3/06e0a58e-acac-41d4-8a5a-6e6be756364c"
//        
//                guard let url: URL = URL(string: urlString) else {
//                    completion(.failure(.invalidURL(url: urlString)))
//                    return
//                }
//        
//                let task = URLSession.shared.dataTask(with: url) { (data, respose, error) in
//        
//                    if let error {
//                        print("ERROR \(#function) Detalhe do erro: \(error.localizedDescription)")
//                        DispatchQueue.main.async {
//                            completion(.failure(.networkFailure(error)))
//                        }
//                        return
//                    }
//        
//                    guard let data else {
//                        DispatchQueue.main.async {
//                            completion(.failure(.noData))
//                        }
//                        return
//                    }
//        
//                    guard let respose = respose as? HTTPURLResponse, respose.statusCode == 200 else {
//                        DispatchQueue.main.async {
//                            completion(.failure(.invalidResponse))
//                        }
//                        return
//                    }
//        
//                    do {
//                        let personList: PersonList = try JSONDecoder().decode(PersonList.self, from: data)
//                        print("SUCCESS -> \(#function)")
//                        DispatchQueue.main.async {
//                            completion(.success(personList))
//                        }
//                    } catch  {
//                        print("ERROR -> \(#function)")
//                        DispatchQueue.main.async {
//                            completion(.failure(NetworkError.decodingError(error)))
//                        }
//                    }
//                }
//                task.resume()
//        
//            }
        
    }
}
