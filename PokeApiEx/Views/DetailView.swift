//
//  DetailView.swift
//  PokeApiEx
//
//  Created by Matias Alvarez on 2/12/24.
//

import SwiftUI

struct DetailView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject var pokemonManager: PokemonManager
    @ObservedObject var vm: DetailViewModel
    
    var body: some View {
        ScrollView {
            VStack (spacing: 16){
                pokemonImage
                pokemonDetails
                if let evolutions = vm.detail?.evolutions {
                    pokemonEvolutions(evolutions: evolutions)
                }
            }
        }
        .font(.title)
        .onAppear {
            Task {
                await vm.getDetails()
            }
        }
        .frame(maxWidth: .infinity)
        .appAlert($vm.alert)
    }
}

#Preview {
    NavigationStack {
        let coordinator = Coordinator()
        let pokemonManager = PokemonManager()
        let pokemon = PokemonPreview().eevee
        DetailView(vm: DetailViewModel(pokemonManager: pokemonManager, pokemon: pokemon))
            .environmentObject(pokemonManager)
            .environmentObject(coordinator)
    }
}

extension DetailView {
    
    private var pokemonImage: some View {
        Image(uiImage: vm.pokemon.uiImage)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity, maxHeight: 300)
            .padding()
    }
    
    private var pokemonDetails: some View {
        VStack {
            Text("#\(vm.pokemon.pokemon.id) - \(vm.pokemon.pokemon.name.uppercased())")
                .font(.largeTitle)
            Text("Height: \(vm.pokemon.pokemon.height)")
            Text("Weight: \(vm.pokemon.pokemon.weight)")
            Text("Types: \(vm.pokemon.pokemon.types.map(\.type.name).joined(separator: ", "))")
        }
    }
    
    private func pokemonEvolutions (evolutions: [APPPokemon]) -> some View {
        VStack {
            Text("Evolutions:")
            let colums = Array(repeating: GridItem(.flexible(maximum: 300), spacing: 0),count: 3)
            LazyVGrid(columns: colums) {
                ForEach(evolutions) { evolution in
                    VStack {
                        Image(uiImage: evolution.uiImage)
                            .resizable()
                            .scaledToFit()
                        Text("#\(evolution.pokemon.id) - \(evolution.pokemon.name.uppercased())")
                    }
                }
            }
            .padding()
        }
    }
}
