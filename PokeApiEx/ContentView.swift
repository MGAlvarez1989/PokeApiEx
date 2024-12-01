//
//  ContentView.swift
//  PokeApiEx
//
//  Created by Matias Alvarez on 1/12/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm = HomeViewModel()
    @State var results = [PokemonList.Result]()
    
    var body: some View {
        List {
            ForEach(results, id: \.name) { pokemon in
                Text(pokemon.name)
            }
        }
        .padding()
        .onAppear {
            Task {
                let pokemonList = try await vm.getPokemonList()
                results = pokemonList.results
            }
        }
    }
        
}

#Preview {
    ContentView()
}
