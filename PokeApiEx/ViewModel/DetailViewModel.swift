//
//  DetailViewModel.swift
//  PokeApiEx
//
//  Created by Matias Alvarez on 3/12/24.
//

import SwiftUI

struct DetailPokemon {
    var species: Species
    var evolutionChain: EvolutionChain
    var evolutions: [HomePokemon]?
}

class DetailViewModel: ObservableObject {
    
    @Published var pokemon: HomePokemon
    @Published var detail: DetailPokemon?
    @Published var isLoading: Bool = false
    
    init(pokemon: HomePokemon) {
        self.pokemon = pokemon
    }
    
    @MainActor
    func getDetails() async throws {
        let species = try await getSpecies()
        let evolutionChain = try await getEvolutionChain(from: species)
        if evolutionChain.chain.evolvesTo.isEmpty {
            detail = DetailPokemon(species: species, evolutionChain: evolutionChain)
        } else {
            let pokemonsEvolutions = try await getEvolutionsPokemons(from: evolutionChain)
            detail = DetailPokemon(species: species, evolutionChain: evolutionChain, evolutions: pokemonsEvolutions)
        }
    }
    
    private func getSpecies() async throws -> Species {
        let speciesURL = URL(string: pokemon.pokemon.species.url)
        let species = try await APICaller.shared.callService(speciesURL, Species.self)
        return species
    }
    
    private func getEvolutionChain(from species: Species) async throws -> EvolutionChain {
        let evolutionChainURL = URL(string: species.evolutionChain.url)
        let evolutionChain = try await APICaller.shared.callService(evolutionChainURL, EvolutionChain.self)
        return evolutionChain
    }
    
    private func getStringEvolutions(from chain: EvolutionChain) -> [String] {
        
        var evolutions: [String] = []
        evolutions.append(contentsOf: getAllEvolutions(from: chain.chain))
        return evolutions
        
        func getAllEvolutions(from chain: EvolutionChain.Chain) -> [String] {
            var evolutions: [String] = []
            evolutions.append(chain.species.name)
            for evolution in chain.evolvesTo {
                evolutions.append(contentsOf: getAllEvolutions(from: evolution))
            }
            return evolutions
        }
        
        func getAllEvolutions(from evolvesTo: EvolutionChain.Chain.EvolvesTo) -> [String] {
            var evolutions: [String] = []
            evolutions.append(evolvesTo.species.name)
            for evolution in evolvesTo.evolvesTo {
                evolutions.append(contentsOf: getAllEvolutions(from: evolution))
            }
            return evolutions
        }
    }
    
    private func getEvolutionsPokemons(from evolutionChain: EvolutionChain) async throws -> [HomePokemon] {
        let allEvolutions = getStringEvolutions(from: evolutionChain)
        var pokemonsEvolution: [HomePokemon] = []
        for evolution in allEvolutions {
            let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(evolution)")
            let pokemon = try await APICaller.shared.callService(url, Pokemon.self)
            let imageURL = URL(string: pokemon.sprites.other.officialArtwork.frontDefault)
            let dataImage = try await APICaller.shared.downloadImage(imageURL)
            guard let image = UIImage(data: dataImage) else {continue}
            let pokemonEvolution = HomePokemon(pokemon: pokemon, uiImage: image)
            pokemonsEvolution.append(pokemonEvolution)
        }
        return pokemonsEvolution
    }
}
