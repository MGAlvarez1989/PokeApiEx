//
//  APICallerError.swift
//  PokeApiEx
//
//  Created by Matias Alvarez on 15/1/25.
//

import Foundation

enum APICallerError: Error, LocalizedError {
    case badResponse
    case invalidURL
    case downloadImage
    case callServiceError
    
    var errorDescription: String? {
        switch self {
        case .badResponse:
            return "La respuesta del servidor es inválida"
        case .invalidURL:
            return "URL inválida"
        case .downloadImage:
            return "Error al descargar imagen"
        case .callServiceError:
            return "Error al llamar el servicio"
        }
    }
}
