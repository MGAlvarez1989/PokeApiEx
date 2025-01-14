//
//  PokemonPreview.swift
//  PokeApiEx
//
//  Created by Matias Alvarez on 3/12/24.
//

import SwiftUI

struct PokemonPreview {
    
    let bulbasaur = APPPokemon(
        pokemon: APIPokemon(
            id: 1,
            name: "bulbasaur",
            height: 7,
            weight: 69,
            species: APIPokemon.Species(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon-species/1/"),
            sprites: APIPokemon.Sprites(other: APIPokemon.Sprites.Other(officialArtwork: APIPokemon.Sprites.Other.OfficialArtwork(
                frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png"))),
            types: [
                APIPokemon.TypeElement(slot: 1, type: APIPokemon.TypeElement.TypeSpecies(name: "grass", url: "https://pokeapi.co/api/v2/type/12/")),
                APIPokemon.TypeElement(slot: 2, type: APIPokemon.TypeElement.TypeSpecies(name: "poison", url: "https://pokeapi.co/api/v2/type/4/"))
            ]
        ),
        uiImage: UIImage(imageLiteralResourceName: "bulbasaur")
    )
    
//    let species = Species(id: 1,
//                          name: "bulbasaur",
//                          evolutionChain: Species.EvolutionChain(url: "https://pokeapi.co/api/v2/evolution-chain/1/"),
//                          evolvesFromSpecies: nil,
//                          generation: Species.Generation(name: "generation-i", url: "https://pokeapi.co/api/v2/generation/1/"))
//    
//    let evolutionChain = EvolutionChain(id: 1,
//                                        chain:
//                                            EvolutionChain.Chain(
//                                                species: EvolutionChain.Chain.SpeciesReference(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon-species/1/"),
//                                                evolvesTo: [
//                                                    EvolutionChain.Chain.EvolvesTo(species: EvolutionChain.Chain.SpeciesReference(
//                                                        name: "ivysaur",
//                                                        url: "https://pokeapi.co/api/v2/pokemon-species/2/"
//                                                    ),evolvesTo: [EvolutionChain.Chain.EvolvesTo(species: EvolutionChain.Chain.SpeciesReference(
//                                                        name: "venusaur",
//                                                        url: "https://pokeapi.co/api/v2/pokemon-species/3/"
//                                                    ), evolvesTo: [])])
//                                                ]))
    
    let Kangaskhan = APPPokemon(
        pokemon: APIPokemon(
            id: 172,
            name: "kangaskhan",
            height: 22,
            weight: 69,
            species: APIPokemon.Species(name: "kangaskhan", url: "https://pokeapi.co/api/v2/pokemon-species/115/"),
            sprites: APIPokemon.Sprites(other: APIPokemon.Sprites.Other(officialArtwork: APIPokemon.Sprites.Other.OfficialArtwork(
                frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/115.png"))),
            types: [
                APIPokemon.TypeElement(slot: 1, type: APIPokemon.TypeElement.TypeSpecies(name: "normal", url: "https://pokeapi.co/api/v2/type/1/"))
            ]
        ),
        uiImage: UIImage(imageLiteralResourceName: "kangaskhan")
    )
    
    let eevee = APPPokemon(
        pokemon: APIPokemon(
            id: 133,
            name: "eevee",
            height: 3,
            weight: 65,
            species: APIPokemon.Species(name: "eevee", url: "https://pokeapi.co/api/v2/pokemon-species/133/"),
            sprites: APIPokemon.Sprites(other: APIPokemon.Sprites.Other(officialArtwork: APIPokemon.Sprites.Other.OfficialArtwork(
                frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/133.png"))),
            types: [
                APIPokemon.TypeElement(slot: 1, type: APIPokemon.TypeElement.TypeSpecies(name: "normal", url: "https://pokeapi.co/api/v2/type/1/"))
            ]
        ),
        uiImage: UIImage(imageLiteralResourceName: "eevee")
    )
    
    let espeon = APPPokemon(
        pokemon: APIPokemon(
            id: 196,
            name: "espeon",
            height: 3,
            weight: 65,
            species: APIPokemon.Species(name: "eevee", url: "https://pokeapi.co/api/v2/pokemon-species/196/"),
            sprites: APIPokemon.Sprites(other: APIPokemon.Sprites.Other(officialArtwork: APIPokemon.Sprites.Other.OfficialArtwork(
                frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/196.png"))),
            types: [
                APIPokemon.TypeElement(slot: 1, type: APIPokemon.TypeElement.TypeSpecies(name: "psychic", url: "https://pokeapi.co/api/v2/type/14/"))
            ]
        ),
        uiImage: UIImage(imageLiteralResourceName: "espeon")
    )
    
}

