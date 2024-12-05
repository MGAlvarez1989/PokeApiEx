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
        ScrollView {
            VStack (spacing: 16){
                Image(uiImage: vm.pokemon.uiImage)
                Text("#\(vm.pokemon.pokemon.id) - \(vm.pokemon.pokemon.name.uppercased())")
                    .font(.largeTitle)
                Text("Height: \(vm.pokemon.pokemon.height)")
                Text("Weight: \(vm.pokemon.pokemon.weight)")
                Text("Types: \(vm.pokemon.pokemon.types.map(\.type.name).joined(separator: ", "))")
                Text("Evolutions:")
                HStack {
                    if let detail = vm.detail {
                        ForEach(detail.evolutions) { evolution in
                            Image(uiImage: evolution.uiImage)
                                .resizable()
                                .scaledToFit()
                        }
                    }
                }
            }
        }
        
        .font(.title)
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
