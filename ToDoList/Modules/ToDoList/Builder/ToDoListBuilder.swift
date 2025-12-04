//
//  ToDoListBuilder.swift
//  ToDoList
//
//  Created by Alex Arsentev on 2025-12-04.
//

import Foundation

final class ToDoListBuilder {
    
    static func build() -> ToDoListView {
        let interactor = ToDoListInteractor()
        let router = ToDoListRouter()
        let presenter = ToDoListPresenter()
        
        presenter.interactor = interactor
        interactor.presenter = presenter
        presenter.router = router
        
        return ToDoListView(presenter: presenter)
    }
}
