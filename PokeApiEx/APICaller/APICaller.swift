//
//  APICaller.swift
//  PokeApiEx
//
//  Created by Matias Alvarez on 1/12/24.
//

import Foundation

class APICaller {
    
    private init() {}
    
    static let shared = APICaller()
    
    func callService<T: Decodable>(_ url: URL?, _ modelType: T.Type) async throws -> T {
        do {
            guard let url else {fatalError("URL Error")}
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse else {
                fatalError("HTTP Response Error")
            }
//            print(try JSONSerialization.jsonObject(with: data))
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            print("Call Service Error: \(error)")
            throw error
        }
    }
    
    func downloadImage(_ url: URL?) async throws -> Data {
        guard let url else {fatalError("URL Error")}
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse else {
            fatalError("HTTP Response Error")
        }
        return data
    }
    
    func buildRequest(_ requestModel: RequestModel) -> URLRequest {
        var serviceURL = URLComponents(string: requestModel.getURL())
        serviceURL?.queryItems = requestModel.queryItems
        
        guard let componentURL = serviceURL?.url else {fatalError("buildRequest error")}
        
        var request = URLRequest(url: componentURL)
        request.httpMethod = requestModel.httpMethod
        return request
    }
    
}
