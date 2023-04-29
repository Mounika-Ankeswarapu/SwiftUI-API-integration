//
//  APIManagerUsingProtocols.swift
//  PokemonData
//
//  Created by Mounika Ankeswarapu on 29/04/23.
//
import Foundation

class APIManager{
    static let shared = APIManager()
    private init() {}
    
    
    
    func fetch<T: Codable>(with url: String , type: T.Type) async -> (Result<T, NetworkError>) {
        guard let url = URL(string: url) else {return .failure(.badURL) }
        let urlrequest = URLRequest(url: url)
        do {
            let (data, _) = try await URLSession.shared.data(for: urlrequest)
            let responseData = await formatDataModel(data: data, type: T.self)
            switch responseData {
            case .success(let dataModel):
                return .success(dataModel)
            case .failure(let error):
                return .failure(error)
        }
        } catch  {
            print("Network Error")
            return .failure(.networkError)
        }
    
}

func formatDataModel<T: Codable>(data: Data, type: T.Type) async -> (Result<T, NetworkError>) {
    if let responseModel = try? JSONDecoder().decode(T.self, from: data) {
        return .success(responseModel)
    }else {
        return .failure(.parseError)
    }
        
    }
}
