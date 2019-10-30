//
//  NetworkEnvironmentController.swift
//  NetworkEnvironmentMova
//
//  Created by Valentyn Mialin on 30.10.2019.
//

import Foundation

public class NetworkEnvironmentController {
    public private(set) lazy var currentEnvironment = loadEnvironment()
    private let defaults: UserDefaults
    private let defaultsKey = "networkEnvironmen"

    public init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    public func changeEnvironment(to environment: NetworkEnvironment) {
        currentEnvironment = environment
        defaults.setValue(environment.rawValue, forKey: defaultsKey)
    }

    private func loadEnvironment() -> NetworkEnvironment {
        let rawValue = defaults.string(forKey: defaultsKey)
        return rawValue.flatMap(NetworkEnvironment.init) ?? .production
    }
}
