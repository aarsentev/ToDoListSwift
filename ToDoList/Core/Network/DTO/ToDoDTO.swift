//
//  ToDoDTO.swift
//  ToDoList
//
//  Created by Alex Arsentev on 2025-12-04.
//

import Foundation

struct TodosResponse: Decodable {
    let todos: [TodoDTO]
    let total: Int
    let skip: Int
    let limit: Int
}

struct TodoDTO: Decodable {
    let id: Int
    let todo: String
    let completed: Bool
    let userId: Int
    
    func toEntity() -> ToDoEntity {
        return ToDoEntity(
            id: id,
            todo: todo,
            completed: completed,
            userId: userId,
            createdDate: Date()
        )
    }
}
