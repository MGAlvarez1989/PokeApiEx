//
//  Pokemon.swift
//  PokeApiEx
//
//  Created by Matias Alvarez on 1/12/24.
//

import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let species: Species
    let sprites: Sprites
    let types: [TypeElement]
    
    struct Species: Codable {
        let name: String
        let url: String
    }
    
    struct Sprites: Codable {
        let other: Other
        
        struct Other: Codable {
            let officialArtwork: OfficialArtwork
            
            enum CodingsKeys: String, CodingKey {
                case officialArtwork = "official-artwork"
            }
            
            struct OfficialArtwork: Codable {
                let frontDefault: String
                
                enum CodingsKeys: String, CodingKey {
                    case frontDefault = "front_default"
                }
            }
        }
    }
    
    struct TypeElement: Codable {
        let slot: Int
        let type: TypeSpecies
        
        struct TypeSpecies: Codable {
            let name: String
            let url: String
        }
    }
}
