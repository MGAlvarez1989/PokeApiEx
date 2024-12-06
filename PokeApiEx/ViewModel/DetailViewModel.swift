//
//  DetailViewModel.swift
//  PokeApiEx
//
//  Created by Matias Alvarez on 3/12/24.
//

import SwiftUI

class DetailViewModel: ObservableObject {
    
    @Published var pokemon: APPPokemon
    @Published var detail: APPDetailPokemon?
    @Published var isLoading: Bool = false
    
    init(pokemon: APPPokemon) {
        self.pokemon = pokemon
    }
    
    @MainActor
    func getDetails() async throws {
        let species = try await getSpecies()
        let evolutionChain = try await getEvolutionChain(from: species)
        if evolutionChain.chain.evolvesTo.isEmpty {
            detail = APPDetailPokemon(species: species, evolutionChain: evolutionChain)
        } else {
            let pokemonsEvolutions = try await getEvolutionsPokemons(from: evolutionChain)
            detail = APPDetailPokemon(species: species, evolutionChain: evolutionChain, evolutions: pokemonsEvolutions)
        }
    }
    
    private func getSpecies() async throws -> APISpecies {
        let speciesURL = URL(string: pokemon.pokemon.species.url)
        let species = try await APICaller.shared.callService(speciesURL, APISpecies.self)
        return species
    }
    
    private func getEvolutionChain(from species: APISpecies) async throws -> APIEvolutionChain {
        let evolutionChainURL = URL(string: species.evolutionChain.url)
        let evolutionChain = try await APICaller.shared.callService(evolutionChainURL, APIEvolutionChain.self)
        return evolutionChain
    }
    
    private func getStringEvolutions(from chain: APIEvolutionChain) -> [String] {
        
        var evolutions: [String] = []
        evolutions.append(contentsOf: getAllEvolutions(from: chain.chain))
        return evolutions
        
        func getAllEvolutions(from chain: APIEvolutionChain.Chain) -> [String] {
            var evolutions: [String] = []
            evolutions.append(chain.species.name)
            for evolution in chain.evolvesTo {
                evolutions.append(contentsOf: getAllEvolutions(from: evolution))
            }
            return evolutions
        }
        
        func getAllEvolutions(from evolvesTo: APIEvolutionChain.Chain.EvolvesTo) -> [String] {
            var evolutions: [String] = []
            evolutions.append(evolvesTo.species.name)
            for evolution in evolvesTo.evolvesTo {
                evolutions.append(contentsOf: getAllEvolutions(from: evolution))
            }
            return evolutions
        }
    }
    
    private func getEvolutionsPokemons(from evolutionChain: APIEvolutionChain) async throws -> [APPPokemon] {
        let allEvolutions = getStringEvolutions(from: evolutionChain)
        var pokemonsEvolution: [APPPokemon] = []
        for evolution in allEvolutions {
            let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(evolution)")
            let pokemon = try await APICaller.shared.callService(url, APIPokemon.self)
            let imageURL = URL(string: pokemon.sprites.other.officialArtwork.frontDefault)
            let dataImage = try await APICaller.shared.downloadImage(imageURL)
            guard let image = UIImage(data: dataImage) else {continue}
            let pokemonEvolution = APPPokemon(pokemon: pokemon, uiImage: image)
            pokemonsEvolution.append(pokemonEvolution)
        }
        return pokemonsEvolution
    }
}
