//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Alex Arsentev on 2025-12-03.
//

import SwiftUI

@main
struct ToDoListApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ToDoListBuilder.build()
        }
    }
}
