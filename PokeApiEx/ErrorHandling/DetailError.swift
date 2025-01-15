//
//  DetailError.swift
//  PokeApiEx
//
//  Created by Matias Alvarez on 15/1/25.
//

import Foundation

enum DetailError: Error, LocalizedError {
    case fetchEvolutionUIImage
    
    var errorDescription: String? {
        switch self {
        case .fetchEvolutionUIImage: "Error getting evolution image"
        }
    }
}
