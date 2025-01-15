//
//  HomeError.swift
//  PokeApiEx
//
//  Created by Matias Alvarez on 15/1/25.
//

import Foundation

enum HomeError: Error, LocalizedError {
    case noList
    case unknown(String)
    
    var title: String {
        switch self {
        case .noList, .unknown: return "Error"
        }
    }
    
    var errorDescription: String? {
        switch self {
        case .noList: return "No list found"
        case .unknown(let message): return message
        }
    }
}
