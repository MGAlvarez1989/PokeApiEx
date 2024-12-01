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
    
    func callService<T: Decodable>(requestModel: RequestModel, _ modelType: T.Type) async throws -> T {
        let request = buildRequest(requestModel)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                fatalError("HTTP Response Error")
            }
            let decodedData = try JSONDecoder().decode(T.self, from: data)
//            print(try JSONSerialization.jsonObject(with: data))
            return decodedData
        } catch {
            print("Call Service Error: \(error)")
            throw error
        }
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
