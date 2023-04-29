//
//  APIManager.swift
//  PokemonData
//
//  Created by Mounika Ankeswarapu on 27/04/23.
// This file is just for reference on how to create extension and protocol for the same APIManager file
//


import Foundation
class APIManagerUsingProtocol {
    static let shared = APIManagerUsingProtocol()
    private init() { }
}

extension APIManagerUsingProtocol: APIHelperProtocol {
    func fetch<T>(with url: String, type: T.Type) async -> (Result<T, NetworkError>) where T: Decodable, T: Encodable {
        guard let url = URL(string: url) else { return .failure(.badURL) }
        let urlRequest = URLRequest(url: url)
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let responseData = await formatDataModel(data: data, type: T.self)
            switch responseData {
            case let .success(dataModel):
                return .success(dataModel)
            case let .failure(error):
                return .failure(error)
            }
        } catch {
            print("Network error")
            return .failure(.networkError)
        }
    }

    func formatDataModel<T>(data: Data, type: T.Type) async -> (Result<T, NetworkError>) where T: Decodable, T: Encodable {
        if let responseModel = try? JSONDecoder().decode(T.self, from: data) {
            return .success(responseModel)
        } else {
            return .failure(.parseError)
        }
    }
}

protocol APIFetchProtocol {
    func fetch<T: Codable>(with url: String, type: T.Type) async -> (Result<T, NetworkError>)
}

protocol JsonHandlerProtocol {
    func formatDataModel<T: Codable>(data: Data, type: T.Type) async -> (Result<T, NetworkError>)
}

protocol APIHelperProtocol: APIFetchProtocol, JsonHandlerProtocol {
}


