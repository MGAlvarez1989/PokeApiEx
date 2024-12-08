//
//  ContentView.swift
//  PokeApiEx
//
//  Created by Matias Alvarez on 1/12/24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject var pokemonManager: PokemonManager
    @ObservedObject var vm: HomeViewModel
    
    
    let colums = Array(repeating: GridItem(.flexible(minimum: 300), spacing: 0),count: 3)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: colums) {
                ForEach(pokemonManager.appPokemonList) { pokemon in
                    VStack {
                        Image(uiImage: pokemon.uiImage)
                            .resizable()
                            .scaledToFit()
                        Text("#\(pokemon.pokemon.id) - \(pokemon.pokemon.name.uppercased())")
                            .font(.largeTitle)
                    }
                    .onAppear {
                        if pokemon == pokemonManager.appPokemonList.last && !vm.isLoading {
                            Task {
                                do {
                                    try await vm.getList()
                                } catch {
                                    throw error
                                }
                            }
                        }
                    }
                    .onTapGesture {
                        pokemonManager.pokemonSelected = pokemon
                        coordinator.push(.details(pokemon: pokemon))
                    }
                }
                if vm.isLoading {
                    ProgressView()
                        .scaleEffect(3)
                        .frame(minWidth: 300, minHeight: 300)
                        .padding()
                }
            }
            .padding()
            .onAppear {
                if pokemonManager.appPokemonList.isEmpty {
                    Task {
                        do {
                            try await vm.getList()
                        } catch {
                            throw error
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    let pokemonManager = PokemonManager()
    HomeView(vm: HomeViewModel(pokemonManager: pokemonManager))
        .environmentObject(pokemonManager)
}
