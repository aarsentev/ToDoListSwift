//
//  AddEditToDoProtocols.swift
//  ToDoList
//
//  Created by Alex Arsentev on 2025-12-05.
//

import Foundation

// MARK: - Presenter Protocol
protocol AddEditToDoPresenterProtocol: ObservableObject {
    var title: String { get }
    var dateText: String { get }
    var text: String { get set }
    var isLoading: Bool { get }
    var errorMessage: String? { get set }
    
    func viewDidLoad()
    func saveToDo()
    func didSaveToDo()
    func didFailWithError(_ error: Error)
}

// MARK: - Interactor Protocol
protocol AddEditToDoInteractorProtocol: AnyObject {
    func saveToDo(
        _ todo: ToDoEntity,
        completion: @escaping (Result<ToDoEntity, Error>) -> Void
    )
    
    func createToDo(
        text: String,
        completion: @escaping (Result<ToDoEntity, Error>) -> Void
    )
}

// MARK: - Router Protocol
protocol AddEditToDoRouterProtocol: AnyObject {
    var dismissAction: (() -> Void)? { get set }
    func dismiss()
}

