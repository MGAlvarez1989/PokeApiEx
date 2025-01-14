//
//  APICaller.swift
//  PokeApiEx
//
//  Created by Matias Alvarez on 1/12/24.
//

import Foundation

enum APICallerError: Error {
    case invalidURL
    case downloadImage
    case callServiceError
}
extension APICallerError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL inválida"
        case .downloadImage:
            return "Error al descargar imagen"
        case .callServiceError:
            return "Error al llamar el servicio"
        }
    }
}

class APICaller {
    
    private init() {}
    
    static let shared = APICaller()
    
    func callService<T: Decodable>(_ url: URL?, _ modelType: T.Type) async throws -> T {
        do {
            guard let url else {throw APICallerError.invalidURL}
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }
//            print(try JSONSerialization.jsonObject(with: data))
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
//            print("Call Service Error: \(error)")
            throw APICallerError.callServiceError
        }
    }
    
    func downloadImage(_ url: URL?) async throws -> Data {
        guard let url else {throw APICallerError.invalidURL}
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }
            return data
        } catch {
            throw APICallerError.downloadImage
        }
    }
    
}
