//
//  Service.swift
//  MyNFT
//
//  Created by Lucas Gomesx on 02/12/23.
//

import Foundation
import Combine

enum HTTPMethod: String {
    case get = "GET"
}

class Service {
    
    func request<T: Codable>(_ request: String, method: HTTPMethod, modelType: T.Type) -> AnyPublisher<T, Error> {
        guard let url = URL(string: request) else {
            return Fail(error: NetworkError.invalidURL(url: request)).eraseToAnyPublisher()
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .mapError { error in
                NetworkError.networkError(error: error)
            }
            .flatMap { data, response -> AnyPublisher<T, Error> in
                guard let httpResponse = response as? HTTPURLResponse else {
                    return Fail(error: NetworkError.invalidResponse).eraseToAnyPublisher()
                }

                guard (200..<300).contains(httpResponse.statusCode) else {
                    return Fail(error: NetworkError.invalidStatusCode(statusCode: httpResponse.statusCode)).eraseToAnyPublisher()
                }

                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(T.self, from: data)
                    return Just(decodedData).setFailureType(to: Error.self).eraseToAnyPublisher()
                } catch {
                    return Fail(error: NetworkError.decodeError(error: error)).eraseToAnyPublisher()
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
