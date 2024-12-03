//
//  DetailViewModel.swift
//  PokeApiEx
//
//  Created by Matias Alvarez on 3/12/24.
//

import Foundation

struct DetailPokemon {
    //TODO: Generar DetailPokemon
}

class DetailViewModel: ObservableObject {
    
    @Published var pokemon: HomePokemon
    @Published var isLoading: Bool = false
    
    init(pokemon: HomePokemon) {
        self.pokemon = pokemon
    }
    
    func getDetails() async throws {
        let pokemon = pokemon.pokemon
        let speciesURL = URL(string: pokemon.species.url)
        let species = try await APICaller.shared.callService(speciesURL, Species.self)
        print("Species: \(species)")
        let evolutionChainURL = URL(string: species.evolutionChain.url)
        let evolutionChain = try await APICaller.shared.callService(evolutionChainURL, EvolutionChain.self)
        print("Evolution Chain: \(evolutionChain)")
    }
    
}
