//
//  ApiView.swift
//  PokemonData
//
//  Created by Mounika Ankeswarapu on 27/04/23.
//

import Foundation
import SwiftUI

struct ApiView: View {
    @StateObject var viewModel = ApiViewModel()
    var body: some View {
        NavigationStack {
            List(viewModel.result , id: \.self) { result in
                Text(result.name ?? "")
                onTapGesture {
                    viewModel.selectedPokemonUrl = result.url ?? ""
                    viewModel.navigateToDetail = true
                }
            } .task {
                await viewModel.fetchPokemon()
            }
            .navigationTitle("Pokemon" .capitalized)
            .navigationDestination(isPresented: $viewModel.navigateToDetail, destination: {
                PokemonDetailView().environmentObject(viewModel)
            })
        }
    }
}

struct ApiView_Previews: PreviewProvider {
    static var previews: some View {
        ApiView()
    }
}
