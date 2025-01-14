//
//  HomeViewModel.swift
//  PokeApiEx
//
//  Created by Matias Alvarez on 1/12/24.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var homePokemons: [APPPokemon] = []
    @Published var isLoading = false
    var list: APIPokemonList?
    var pokemon: APIPokemon?
    var pokemonImage: UIImage?
    
    @MainActor
    func getList() async throws {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        var url: URL?
        
        if list == nil {
            url = URL(string: "https://pokeapi.co/api/v2/pokemon")
        } else {
            guard let next = list?.next else { return }
            url = URL(string: next)
        }
        do {
            list = try await APICaller.shared.callService(url, APIPokemonList.self)
            if let list {
                for pokemon in list.results {
                    try await getInfo(stringURL: pokemon.url)
                    if let pokemon = self.pokemon, let pokemonImage = self.pokemonImage {
                        homePokemons.append(APPPokemon(pokemon: pokemon, uiImage: pokemonImage))
                    }
                }
            }
        } catch {
            throw error
        }
    }
    
    private func getInfo(stringURL: String) async throws {
        let url = URL(string: stringURL)
        
        do {
            let model = try await APICaller.shared.callService(url, APIPokemon.self)
            try await getImage(stringURL: model.sprites.other.officialArtwork.frontDefault)
            pokemon = model
        } catch {
            throw error
        }
    }
    
    private func getImage(stringURL: String) async throws {
        let url = URL(string: stringURL)
        do {
            let data = try await APICaller.shared.downloadImage(url)
            if let image = UIImage(data: data) {
                pokemonImage = image
            }
        } catch {
            print("Error: \(error)")
        }
    }
}
