//
//  HomeViewModel.swift
//  PokeApiEx
//
//  Created by Matias Alvarez on 1/12/24.
//

import SwiftUI


enum HomeError: Error {
    case noList
    case unknown(String)
}

extension HomeError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noList: return "No list found"
        case .unknown(let message): return message
        }
    }
}

class HomeViewModel: ObservableObject {
    
    private var pokemonManager: PokemonManager
    
    @Published var showError = false
    @Published var error: HomeError?
    @Published var isLoading = false
    var pokemon: APIPokemon?
    var pokemonImage: UIImage?
    
    init(pokemonManager: PokemonManager) {
        self.pokemonManager = pokemonManager
    }
    
    @MainActor
    func getList() async {
        //check if we are not already loading the list
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        do {
            let url = try getURL()
            pokemonManager.pokemonList = try await APICaller.shared.callService(url, APIPokemonList.self)
            guard let list = pokemonManager.pokemonList else { throw HomeError.noList }
            
            for pokemon in list.results {
                await getInfo(stringURL: pokemon.url)
                if let pokemon = self.pokemon, let pokemonImage = self.pokemonImage {
                    pokemonManager.appPokemonList.append(APPPokemon(pokemon: pokemon, uiImage: pokemonImage))
                }
            }
        } catch {
            handleError(error)
        }
    }
    
    private func handleError(_ error: any Error) {
        if let homeError = error as? HomeError {
            self.error = homeError
        } else {
            self.error = .unknown(error.localizedDescription)
        }
        self.showError = true
    }
    
    private func getInfo(stringURL: String) async {
        do {
            let url = URL(string: stringURL)
            let model = try await APICaller.shared.callService(url, APIPokemon.self)
            await getImage(stringURL: model.sprites.other.officialArtwork.frontDefault)
            pokemon = model
        } catch {
            handleError(error)
        }
    }
    
    private func getImage(stringURL: String) async {
        do {
            let url = URL(string: stringURL)
            let data = try await APICaller.shared.downloadImage(url)
            if let image = UIImage(data: data) {
                pokemonImage = image
            }
        } catch {
            handleError(error)
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
