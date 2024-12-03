//
//  DetailView.swift
//  PokeApiEx
//
//  Created by Matias Alvarez on 2/12/24.
//

import SwiftUI

struct DetailView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @ObservedObject var vm: DetailViewModel
    
    var body: some View {
        VStack {
            Image(uiImage: vm.pokemon.uiImage)
            Text(vm.pokemon.pokemon.name.uppercased())
                .font(.largeTitle)
            Text("\(vm.pokemon.pokemon.height)")
            Text("\(vm.pokemon.pokemon.weight)")
        }
        .onAppear {
            Task {
                try await vm.getDetails()
            }
        }
    }
}

#Preview {
    ZStack {
        let pokemon = PokemonPreview().homePokemon
        DetailView(vm: DetailViewModel(pokemon: pokemon))
    }
}
