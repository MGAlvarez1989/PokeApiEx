//
//  PokemonManager.swift
//  PokeApiEx
//
//  Created by Matias Alvarez on 6/12/24.
//

import SwiftUI

class PokemonManager: ObservableObject {
    
    var pokemonList: APIPokemonList?
    var pokemon: APIPokemon?
    
    var appPokemonList: [APPPokemon] = []
    var pokemonSelected: APPPokemon?
    var appdetailPokemon: APPDetailPokemon?
    
    
}
