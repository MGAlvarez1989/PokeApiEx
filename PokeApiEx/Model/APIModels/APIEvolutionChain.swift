//
//  EvolutionChain.swift
//  PokeApiEx
//
//  Created by Matias Alvarez on 1/12/24.
//

import Foundation

struct APIEvolutionChain: Codable {
    let id: Int
    let chain: Chain
    
    struct Chain: Codable {
        let species: SpeciesReference
        let evolvesTo: [EvolvesTo]
        
        enum CodingKeys: String, CodingKey {
            case species
            case evolvesTo = "evolves_to"
        }
        
        struct SpeciesReference: Codable {
            let name: String
            let url: String
        }
        
        struct EvolvesTo: Codable {
            let species: SpeciesReference
            let evolvesTo: [EvolvesTo]
            
            enum CodingKeys: String, CodingKey {
                case species
                case evolvesTo = "evolves_to"
            }
        }
    }
}
