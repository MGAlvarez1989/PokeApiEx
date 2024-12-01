//
//  HomeViewModel.swift
//  PokeApiEx
//
//  Created by Matias Alvarez on 1/12/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var pokemonList: PokemonList?
    
    func getPokemonList(_ offset: Int = 0, _ limit: Int = 50) async throws -> PokemonList {
        let queryItems = [URLQueryItem(name: "offset", value: String(offset)),
                          URLQueryItem(name: "limit", value: String(limit))]
        let requestModel = RequestModel(endPoint: .pokemonList, queryItems: queryItems)
        print(requestModel.getURL())
        
        do {
            let model = try await APICaller.shared.callService(requestModel: requestModel, PokemonList.self)
            return model
        } catch {
            throw error
        }
    }
}
