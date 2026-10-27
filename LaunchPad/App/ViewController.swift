//
//  ViewController.swift
//  LaunchPad
//
//  Created by Роман Пичугин on 24.10.2026.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = Bundle.main.url(forResource: "upcoming", withExtension: "json") else {
            print("Файл не найден")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601
            
            let response = try decoder.decode(LaunchResponse.self, from: data)
            
            print("Запусков:", response.results.count)
            
            guard let first = response.results.first else { return }
            print("Ракета:", first.rocket.configuration.name)
            print("Миссия:", first.mission?.name ?? "нет миссии")
            print("Старт:", first.net)
        } catch {
            print(error)
        }
    }
}
