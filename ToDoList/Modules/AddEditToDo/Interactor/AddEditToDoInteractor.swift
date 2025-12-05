//
//  AddEditToDoInteractor.swift
//  ToDoList
//
//  Created by Alex Arsentev on 2025-12-05.
//

import Foundation

final class AddEditToDoInteractor: AddEditToDoInteractorProtocol {
    
    weak var presenter: (any AddEditToDoPresenterProtocol)?
    
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager = .shared) {
        self.coreDataManager = coreDataManager
    }
    
    func saveToDo(_ todo: ToDoEntity, completion: @escaping (Result<ToDoEntity, Error>) -> Void) {
        coreDataManager.updateTodo(todo, completion: completion)
    }
    
    func createToDo(text: String, completion: @escaping (Result<ToDoEntity, Error>) -> Void) {
        let newId = Int(UUID().uuidString)!
        let newTodo = ToDoEntity(
            id: newId,
            todo: text,
            completed: false,
            userId: 0,
            createdDate: Date()
        )
        coreDataManager.createTodo(newTodo, completion: completion)
    }
}

