//
//  LaunchPadEndpoint.swift
//  LaunchPad
//
//  Created by Роман Пичугин on 27.10.2026.
//

import Foundation

nonisolated enum LaunchPadEndpoint: Endpoint {
    
    case list(limit: Int, offset: Int)
    case details(id: String)
    
    var baseURL: String {
        "https://ll.thespacedevs.com/2.2.0"
    }
    
    var path: String {
        switch self {
        case .list:
            return "/launch/upcoming/"
        case .details(let id):
            return "/launch/\(id)/"
        }
    }
    
    var query: [URLQueryItem]? {
        switch self {
        case .list(let limit, let offset):
            return [
                URLQueryItem(name: "limit", value: String(limit)),
                URLQueryItem(name: "offset", value: String(offset))
            ]
            
        case .details:
            return nil
        }
    }
}
