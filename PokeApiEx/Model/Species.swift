//
//  Species.swift
//  PokeApiEx
//
//  Created by Matias Alvarez on 1/12/24.
//

import Foundation

struct Species: Codable {
    let id: Int
    let name: String
    let evolutionChain: EvolutionChain
    let evolvesFromSpecies: EvolvesFromSpecies?
    let generation: Generation
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case evolutionChain = "evolution_chain"
        case evolvesFromSpecies = "evolves_from_species"
        case generation
    }
    
    struct EvolutionChain: Codable {
        let url: String
    }
    
    struct EvolvesFromSpecies: Codable {
        let name: String
        let url: String
    }
    
    struct Generation: Codable {
        let name: String
        let url: String
    }
}
