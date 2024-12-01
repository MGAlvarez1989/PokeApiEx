//
//  RequestModel.swift
//  PokeApiEx
//
//  Created by Matias Alvarez on 1/12/24.
//

import Foundation

struct RequestModel {
    let baseURL = "https://pokeapi.co/api/v2/"
    var endPoint: EndPoints = .empty
    var path = ""
    var queryItems: [URLQueryItem] = []
    var httpMethod = "GET"
    
    func getURL() -> String {
        baseURL + endPoint.rawValue + path
    }
    
    enum EndPoints: String {
        case empty = ""
        case pokemonList = "pokemon"
        case pokemon = "pokemon/"
        case species = "pokemon-species/"
        case evolutionChain = "evolution-chain/"
        
    }
    
}
