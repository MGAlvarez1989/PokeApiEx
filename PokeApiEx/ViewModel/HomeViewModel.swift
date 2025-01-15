//
//  HomeViewModel.swift
//  PokeApiEx
//
//  Created by Matias Alvarez on 1/12/24.
//

import SwiftUI

class HomeViewModel: ViewModel {
    
    private var pokemonManager: PokemonManager
    
    @Published var showError = false
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
            print("GetListError")
            showError(error)
        }
    }
    
    private func getInfo(stringURL: String) async {
        do {
            let url = URL(string: stringURL)
            let model = try await APICaller.shared.callService(url, APIPokemon.self)
            await getImage(stringURL: model.sprites.other.officialArtwork.frontDefault)
            pokemon = model
        } catch {
            print("GetInfoError")
            showError(error)
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
            print("GetImageError")
            showError(error)
        }
    }
    
    private func getURL() throws -> URL?{
        if pokemonManager.pokemonList == nil {
            return URL(string: "https://pokeapi.co/api/v2/pokemon")
        } else {
            guard let next = pokemonManager.pokemonList?.next else { throw APICallerError.invalidURL }
            return URL(string: next)
        }
    }
}
