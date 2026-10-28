//
//  ViewController.swift
//  LaunchPad
//
//  Created by Роман Пичугин on 24.10.2026.
//

import UIKit

class ViewController: UIViewController {
    
    private let service: LaunchServiceProtocol
    
    init(service: LaunchServiceProtocol) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            do {
                let response = try await service.fetchUpcoming(limit: 5, offset: 0)
                print(response.results.count)
                
                for launch in response.results {
                    print(launch.name, launch.net)
                }
            } catch {
                print(error)
            }
        }
        
        
    }
}
