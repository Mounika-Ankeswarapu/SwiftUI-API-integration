//
//  PokemonDetailView.swift
//  PokemonData
//
//  Created by Mounika Ankeswarapu on 27/04/23.
//

import Foundation
import SwiftUI

struct PokemonDetailView: View {
    @EnvironmentObject var viewModel: ApiViewModel
    var body: some View {
        ScrollView {
            ZStack{
                Color.gray
                VStack {
                   
                    ForEach(Array(viewModel.abilities.enumerated()), id: \.offset) { _, item in
                        Text(item.ability?.name ?? "")
                    }
                }
            }
        }.task {
            await viewModel.getPokemonDetail()
        }
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView()
    }
}
