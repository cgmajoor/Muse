//
//  AppConfig.swift
//  Muse
//
//  Created by Ceren Majoor on 08/04/2024.
//

import Foundation

struct AppConfig {
    static var apiKey: String = {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            print("Error API_KEY not found in Bundle")
            return ""
        }
        return apiKey
    }()

    static let pageSize: Int = 1
}
