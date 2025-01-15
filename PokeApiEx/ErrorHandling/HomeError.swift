//
//  HomeError.swift
//  PokeApiEx
//
//  Created by Matias Alvarez on 15/1/25.
//

import Foundation

enum HomeError: Error, LocalizedError {
    case noList
    
    var errorDescription: String? {
        switch self {
        case .noList: return "No list found"
        }
    }
}
