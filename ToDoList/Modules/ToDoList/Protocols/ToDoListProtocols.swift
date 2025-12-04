//
//  ToDoListProtocols.swift
//  ToDoList
//
//  Created by Alex Arsentev on 2025-12-04.
//

import Foundation

// MARK: - Presenter Protocol
protocol ToDoListPresenterProtocol: ObservableObject {
    var todos: [ToDoEntity] { get }
    var searchText: String { get set }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    
    func viewDidLoad()
    func searchTextDidChange()
    func didLoadToDos(_ todos: [ToDoEntity])
    func didSearchToDos(_ todos: [ToDoEntity])
    func didFailWithError(_ error: Error)
}

// MARK: - View Protocol
protocol ToDoListViewProtocol: AnyObject {
    var presenter: (any ToDoListPresenterProtocol)? { get set }
}

// MARK: - Interactor Input Protocol
protocol ToDoListInteractorProtocol: AnyObject {
    func loadToDos(
        completion: @escaping (Result<[ToDoEntity], Error>) -> Void
    )
        
    func searchToDos(
        query: String,
        completion: @escaping (Result<[ToDoEntity], Error>) -> Void
    )
}

// MARK: - Router Protocol
protocol ToDoListRouterProtocol: AnyObject {}

