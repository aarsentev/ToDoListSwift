//
//  AppConfiguration.swift
//  ToDoList
//
//  Created by Alex Arsentev on 2025-12-04.
//

import Foundation

enum AppConfiguration {
    // MARK: - API
    enum API {
        static let baseURL = "https://dummyjson.com"
        
        static let todosEndpoint = "/todos"
        static let todosFullURL = baseURL + todosEndpoint
    }
    
    // MARK: - UserDefaults Keys
    enum UserDefaultsKeys {
        static let isFirstLaunchCompleted = "isFirstLaunchCompleted"
    }
    
    // MARK: - CoreData
    enum CoreData {
        static let containerName = "ToDoList"
    }
}
