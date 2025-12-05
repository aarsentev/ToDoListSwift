//
//  ToDoListRouter.swift
//  ToDoList
//
//  Created by Alex Arsentev on 2025-12-04.
//

import Foundation

enum ToDoListDestination: Hashable {
    case addEditToDo(todo: ToDoEntity?)
}

final class ToDoListRouter: ToDoListRouterProtocol {
    
    var navigationPath: ((ToDoListDestination) -> Void)?
    
    func navigateToAddEditToDo(todo: ToDoEntity?, onSave: @escaping () -> Void) {
        navigationPath?(.addEditToDo(todo: todo))
    }
}
