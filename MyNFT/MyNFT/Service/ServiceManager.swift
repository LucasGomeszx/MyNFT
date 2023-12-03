//
//  ServiceManager.swift
//  MyNFT
//
//  Created by Lucas Gomesx on 03/12/23.
//

import Foundation
import Combine

class ServiceManager {
    
    static let shered: ServiceManager = ServiceManager()
    private let service: Service = Service()
    private var cancellables: Set<AnyCancellable> = []
    
    func getCriptoCoins(completion: @escaping (Result<CriptoModel, Error>) -> Void) {
            let url = "https://api.coingecko.com/api/v3/simple/price?ids=usd&vs_currencies=btc,eth,bnb"
            service.request(url, method: .get, modelType: CriptoModel.self)
                .sink(receiveCompletion: { result in
                    switch result {
                    case .finished:
                        break
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }, receiveValue: { result in
                    completion(.success(result))
                })
                .store(in: &cancellables)
        }

}
