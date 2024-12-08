//
//  HomeViewModel.swift
//  PokeApiEx
//
//  Created by Matias Alvarez on 1/12/24.
//

import SwiftUI

enum HomeError: Error {
    case noList
    case getInfo
    case getImage
}

class HomeViewModel: ObservableObject {
    
    private var pokemonManager: PokemonManager
    
    @Published var isLoading = false
    var pokemon: APIPokemon?
    var pokemonImage: UIImage?
    
    init(pokemonManager: PokemonManager) {
        self.pokemonManager = pokemonManager
    }
    
    @MainActor
    func getList() async throws {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        let url = try getURL()
        pokemonManager.pokemonList = try await APICaller.shared.callService(url, APIPokemonList.self)
        guard let list = pokemonManager.pokemonList else { throw HomeError.noList }
        
        for pokemon in list.results {
            try await getInfo(stringURL: pokemon.url)
            if let pokemon = self.pokemon, let pokemonImage = self.pokemonImage {
                pokemonManager.appPokemonList.append(APPPokemon(pokemon: pokemon, uiImage: pokemonImage))
            }
        }
    }
    
    private func getInfo(stringURL: String) async throws {
        do {
            let url = URL(string: stringURL)
            let model = try await APICaller.shared.callService(url, APIPokemon.self)
            try await getImage(stringURL: model.sprites.other.officialArtwork.frontDefault)
            pokemon = model
        } catch {
            throw HomeError.getInfo
        }
    }
    
    private func getImage(stringURL: String) async throws {
        do {
            let url = URL(string: stringURL)
            let data = try await APICaller.shared.downloadImage(url)
            if let image = UIImage(data: data) {
                pokemonImage = image
            }
        } catch {
            throw HomeError.getImage
        }
    }
    
    private func getURL() throws -> URL?{
        if pokemonManager.pokemonList == nil {
            return URL(string: "https://pokeapi.co/api/v2/pokemon")
        } else {
            guard let next = pokemonManager.pokemonList?.next else { throw URLError(.badURL) }
            return URL(string: next)
        }
    }
}
