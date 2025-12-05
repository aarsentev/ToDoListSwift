//
//  AddEditToDoBuilder.swift
//  ToDoList
//
//  Created by Alex Arsentev on 2025-12-05.
//

import SwiftUI

final class AddEditToDoBuilder {
    static func build(todo: ToDoEntity? = nil) -> some View {
        
        let presenter = AddEditToDoPresenter(todo: todo)
        let interactor = AddEditToDoInteractor()
        let router = AddEditToDoRouter()
        
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.presenter = presenter
        
        return AddEditToDoView(presenter: presenter)
    }
}

