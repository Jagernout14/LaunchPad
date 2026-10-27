//
//  Launch.swift
//  LaunchPad
//
//  Created by Роман Пичугин on 24.10.2026.
//

import Foundation

nonisolated struct LaunchResponse: Codable {
    let next: URL?
    let results: [Launch]
}

nonisolated struct Launch: Codable {
    let name: String
    let id: String
    let net: Date
    let windowStart: Date
    let windowEnd: Date
    let status: Status
    let netPrecision: NetPrecision
    let launchServiceProvider: NamedItem
    let rocket: Rocket
    let mission: Mission?
    let pad: Pad
    let image: URL?
}

nonisolated struct Status: Codable {
    let name: String
    let abbrev: String
}

nonisolated struct NetPrecision: Codable {
    let name: String
    let abbrev: String
}

nonisolated struct Rocket: Codable {
    let configuration: NamedItem
}

nonisolated struct Mission: Codable {
    let name: String
    let description: String
    let orbit: NamedItem
}

nonisolated struct Pad: Codable {
    let name: String
    let location: NamedItem
}

nonisolated struct NamedItem: Codable {
    let name: String
}
