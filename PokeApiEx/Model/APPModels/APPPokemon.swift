//
//  APPPokemon.swift
//  PokeApiEx
//
//  Created by Matias Alvarez on 6/12/24.
//

import SwiftUI

struct APPPokemon: Identifiable, Equatable, Hashable{
    static func == (lhs: APPPokemon, rhs: APPPokemon) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id = UUID().uuidString
    var pokemon: APIPokemon
    var uiImage: UIImage
}
