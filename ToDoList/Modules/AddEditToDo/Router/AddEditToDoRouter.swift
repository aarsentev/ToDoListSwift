//
//  AddEditToDoRouter.swift
//  ToDoList
//
//  Created by Alex Arsentev on 2025-12-05.
//

import Foundation

final class AddEditToDoRouter: AddEditToDoRouterProtocol {
    
    weak var presenter: (any AddEditToDoPresenterProtocol)?
    var dismissAction: (() -> Void)?
    
    func dismiss() {
        dismissAction?()
    }
}

