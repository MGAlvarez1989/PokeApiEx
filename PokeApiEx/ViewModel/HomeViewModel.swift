//
//  HomeViewModel.swift
//  PokeApiEx
//
//  Created by Matias Alvarez on 1/12/24.
//

import SwiftUI

struct HomePokemon: Identifiable, Equatable, Hashable {
    static func == (lhs: HomePokemon, rhs: HomePokemon) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id = UUID().uuidString
    var pokemon: Pokemon
    var uiImage: UIImage
}

class HomeViewModel: ObservableObject {
    
    @Published var homePokemons: [HomePokemon] = []
    @Published var isLoading = false
    var list: PokemonList?
    var pokemon: Pokemon?
    var pokemonImage: UIImage?
    
    @MainActor
    func getList() async throws {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        var url: URL?
        
        if list == nil {
            let requestModel = RequestModel(endPoint: .pokemonList)
            url = URL(string: requestModel.getURL())
        } else {
            guard let next = list?.next else { return }
            url = URL(string: next)
        }
        do {
            list = try await APICaller.shared.callService(url, PokemonList.self)
            if let list {
                for pokemon in list.results {
                    try await getInfo(stringURL: pokemon.url)
                    if let pokemon = self.pokemon, let pokemonImage = self.pokemonImage {
                        homePokemons.append(HomePokemon(pokemon: pokemon, uiImage: pokemonImage))
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
            let model = try await APICaller.shared.callService(url, Pokemon.self)
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
