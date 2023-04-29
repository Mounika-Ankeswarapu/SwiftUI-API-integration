//
//  PokemonDetail.swift
//  PokemonData
//
//  Created by Mounika Ankeswarapu on 27/04/23.
//


import Foundation
struct PokemonDetail : Codable {
    let abilities : [Abilities]?
    

    enum CodingKeys: String, CodingKey {

        case abilities = "abilities"
        
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        abilities = try values.decodeIfPresent([Abilities].self, forKey: .abilities)
        
    }

}
