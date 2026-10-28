//
//  LaunchService.swift
//  LaunchPad
//
//  Created by Роман Пичугин on 27.10.2026.
//

import Foundation

nonisolated protocol LaunchServiceProtocol {
    func fetchUpcoming(limit: Int, offset: Int) async throws -> LaunchResponse
    func fetchDetails(id: String) async throws -> Launch
}

nonisolated final class LaunchService: LaunchServiceProtocol {
    private let client: NetworkClientProtocol
    
    init(client: NetworkClientProtocol) {
        self.client = client
    }
    
    func fetchDetails(id: String) async throws -> Launch {
        try await client.request(LaunchPadEndpoint.details(id: id))
    }
    
    func fetchUpcoming(limit: Int, offset: Int) async throws -> LaunchResponse {
        try await client.request(LaunchPadEndpoint.list(limit: limit, offset: offset))
    }
}
