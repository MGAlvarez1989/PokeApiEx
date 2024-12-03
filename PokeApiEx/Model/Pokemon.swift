//
//  Pokemon.swift
//  PokeApiEx
//
//  Created by Matias Alvarez on 1/12/24.
//

import Foundation

struct Pokemon: Codable, Identifiable, Hashable {
    
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let species: Species
    let sprites: Sprites
    let types: [TypeElement]
    
    struct Species: Codable, Hashable {
        let name: String
        let url: String
    }
    
    struct Sprites: Codable, Hashable {
        
        let other: Other
        
        struct Other: Codable, Hashable {
            static func == (lhs: Pokemon.Sprites.Other, rhs: Pokemon.Sprites.Other) -> Bool {
                lhs.officialArtwork.frontDefault == rhs.officialArtwork.frontDefault
            }
            
            let officialArtwork: OfficialArtwork
            
            enum CodingKeys: String, CodingKey {
                case officialArtwork = "official-artwork"
            }
            
            struct OfficialArtwork: Codable, Hashable {
                let frontDefault: String
                
                enum CodingKeys: String, CodingKey {
                    case frontDefault = "front_default"
                }
            }
        }
    }
    
    struct TypeElement: Codable, Hashable {
        let slot: Int
        let type: TypeSpecies
        
        struct TypeSpecies: Codable, Hashable {
            let name: String
            let url: String
        }
    }
}
