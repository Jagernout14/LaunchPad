//
//  Extensions.swift
//  LaunchPad
//
//  Created by Роман Пичугин on 27.10.2026.
//

import Foundation

nonisolated extension JSONDecoder {
    static let launchPad: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
}
