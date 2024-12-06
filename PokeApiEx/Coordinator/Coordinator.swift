//
//  Coordinator.swift
//  PokeApiEx
//
//  Created by Matias Alvarez on 2/12/24.
//

import SwiftUI

enum Page: Identifiable, Hashable {
    case home
    case details(pokemon: APPPokemon)
    
    var id: Self {
        return self
    }
}

class Coordinator: ObservableObject {
    @Published var path = NavigationPath()
    
    func push(_ page: Page) {
        path.append(page)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case .home:
            HomeView()
        case .details(pokemon: let pokemon):
            DetailView(vm: DetailViewModel(pokemon: pokemon))
        }
    }
}
