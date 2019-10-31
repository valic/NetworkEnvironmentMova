//
//  NetworkEnvironmentController.swift
//  NetworkEnvironmentMova
//
//  Created by Valentyn Mialin on 30.10.2019.
//

import Foundation

public class NetworkEnvironment {
    public private(set) lazy var currentEnvironment = loadEnvironment()
    private let defaults: UserDefaults
    private let defaultsKey = "networkEnvironmen"

    public init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
    
    public func changeEnvironment(to environment: NetworkEnvironmentType) {
        currentEnvironment = environment
        defaults.setValue(environment.rawValue, forKey: defaultsKey)
    }

    private func loadEnvironment() -> NetworkEnvironmentType {
        let rawValue = defaults.string(forKey: defaultsKey)
        return rawValue.flatMap(NetworkEnvironmentType.init) ?? .production
    }
    
    public func selectServerAlertController() -> UIAlertController {
        let alertController = UIAlertController(title: "Select server", message: "", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        NetworkEnvironmentType.allCases.forEach { (networkEnvironment) in
            alertController.addAction(UIAlertAction(title: networkEnvironment.rawValue, style: .default, handler: { _ in
                self.changeEnvironment(to: networkEnvironment)
            }))
        }
        return alertController
    }
}
