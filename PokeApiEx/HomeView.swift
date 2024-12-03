//
//  ContentView.swift
//  PokeApiEx
//
//  Created by Matias Alvarez on 1/12/24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @StateObject var vm = HomeViewModel()
    
    
    let colums = Array(repeating: GridItem(.flexible(minimum: 300), spacing: 0),count: 3)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: colums, content: {
                ForEach(vm.homePokemons) { pokemon in
                    VStack {
                        Image(uiImage: pokemon.uiImage)
                            .resizable()
                            .scaledToFit()
                        Text(pokemon.pokemon.name.uppercased())
                            .font(.largeTitle)
                    }
                    .onAppear {
                        if pokemon == vm.homePokemons.last && !vm.isLoading {
                            Task {
                                try await vm.getList()
                            }
                        }
                    }
                    .onTapGesture {
                        print(pokemon.pokemon.name)
                        coordinator.push(.details(pokemon: pokemon))
                    }
                }
                if vm.isLoading {
                    ProgressView()
                        .scaleEffect(3)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding()
                }
            })
            .padding()
            .onAppear {
                Task {
                    try await vm.getList()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
