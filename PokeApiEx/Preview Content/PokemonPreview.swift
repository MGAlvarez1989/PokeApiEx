//
//  PokemonPreview.swift
//  PokeApiEx
//
//  Created by Matias Alvarez on 3/12/24.
//

import SwiftUI

struct PokemonPreview {
    
    let homePokemon = HomePokemon(
        pokemon: Pokemon(
            id: 1,
            name: "bulbasaur",
            height: 7,
            weight: 69,
            species: Pokemon.Species(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon-species/1/"),
            sprites: Pokemon.Sprites(other: Pokemon.Sprites.Other(officialArtwork: Pokemon.Sprites.Other.OfficialArtwork(
                frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png"))),
            types: [
                Pokemon.TypeElement(slot: 1, type: Pokemon.TypeElement.TypeSpecies(name: "grass", url: "https://pokeapi.co/api/v2/type/12/")),
                Pokemon.TypeElement(slot: 2, type: Pokemon.TypeElement.TypeSpecies(name: "poison", url: "https://pokeapi.co/api/v2/type/4/"))
            ]
        ),
        uiImage: UIImage(imageLiteralResourceName: "bulbasaur")
    )
    
    let species = Species(id: 1,
                          name: "bulbasaur",
                          evolutionChain: Species.EvolutionChain(url: "https://pokeapi.co/api/v2/evolution-chain/1/"),
                          evolvesFromSpecies: nil,
                          generation: Species.Generation(name: "generation-i", url: "https://pokeapi.co/api/v2/generation/1/"))
    
    let evolutionChain = EvolutionChain(id: 1,
                                        chain:
                                            EvolutionChain.Chain(
                                                species: EvolutionChain.Chain.SpeciesReference(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon-species/1/"),
                                                evolvesTo: [
                                                    EvolutionChain.Chain.EvolvesTo(species: EvolutionChain.Chain.SpeciesReference(
                                                        name: "ivysaur",
                                                        url: "https://pokeapi.co/api/v2/pokemon-species/2/"
                                                    ),evolvesTo: [EvolutionChain.Chain.EvolvesTo(species: EvolutionChain.Chain.SpeciesReference(
                                                        name: "venusaur",
                                                        url: "https://pokeapi.co/api/v2/pokemon-species/3/"
                                                    ), evolvesTo: [])])
                                                ]))
    
}
