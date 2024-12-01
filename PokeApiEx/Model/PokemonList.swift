//
//  PokemonList.swift
//  PokeApiEx
//
//  Created by Matias Alvarez on 1/12/24.
//

import Foundation

struct PokemonList: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Result]
    
    struct Result: Codable {
        let name: String
        let url: String
    }
}
