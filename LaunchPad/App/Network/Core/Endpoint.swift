//
//  Endpoint.swift
//  LaunchPad
//
//  Created by Роман Пичугин on 25.10.2026.
//

import Foundation

nonisolated protocol Endpoint {
    var method: HTTPMethod { get }
    var baseURL: String { get }
    var path: String { get }
    var query: [URLQueryItem]? { get }
    var headers: [String: String]? { get }
    var body: Encodable? { get }
}

nonisolated extension Endpoint {
    var method: HTTPMethod { .get }
    var query: [URLQueryItem]? { nil }
    var headers: [String: String]? { nil }
    var body: Encodable? { nil }
    
    func makeRequest() throws -> URLRequest {
        guard var components = URLComponents(string: baseURL + path) else {
            throw NetworkError.badURL
        }
        
        components.queryItems = query
        guard let url = components.url else {
            throw NetworkError.badURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let body {
            do {
                request.httpBody = try JSONEncoder().encode(body)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                throw NetworkError.encodeError
            }
        }
        
        return request
    }
}
