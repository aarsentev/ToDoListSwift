//
//  ToDoEntity.swift
//  ToDoList
//
//  Created by Alex Arsentev on 2025-12-04.
//

import Foundation

struct ToDoEntity: Identifiable, Hashable {
    let id: Int
    var todo: String
    var completed: Bool
    var userId: Int
    let createdDate: Date
    
    // MARK: - Initializers
    init(
        id: Int,
        todo: String,
        completed: Bool = false,
        userId: Int = 0,
        createdDate: Date = Date()
    ) {
        self.id = id
        self.todo = todo
        self.completed = completed
        self.userId = userId
        self.createdDate = createdDate
    }
}
