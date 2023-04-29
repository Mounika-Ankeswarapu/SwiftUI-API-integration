//
//  ApiViewModel.swift
//  PokemonData
//
//  Created by Mounika Ankeswarapu on 27/04/23.
//

import Foundation

@MainActor

class ApiViewModel: ObservableObject {
    @Published var result = [Results]()
    @Published var model: PokemonModel?
    @Published var abilities = [Abilities]()
    @Published var navigateToDetail = false
    
    private let url = "https://pokeapi.co/api/v2/pokemon"
    
    var selectedPokemonUrl = ""
    
    func fetchPokemon() async {
        let responseModel = await APIManagerUsingProtocol.shared.fetch(with: url, type: PokemonModel.self)
        switch responseModel {
        case .success(let data):
            self.model = data
            self.result = data.results ?? []
        case .failure(let error):
            print(error.rawValue)
        }
    }
    
    func getPokemonDetail()  async {
        let responseModel = await APIManagerUsingProtocol.shared.fetch(with: selectedPokemonUrl, type: PokemonDetail.self)
        switch responseModel {
        case .success(let data):
            self.abilities = data.abilities ?? []
        case .failure(let error):
            print(error.rawValue)
        }
    }
    
}


enum NetworkError: String, Error {
    case networkError = "Network Error"
    case badURL = "Check the url string"
    case parseError = "Error occur while parse the Json"
    case other = "Something went wrong"
}
