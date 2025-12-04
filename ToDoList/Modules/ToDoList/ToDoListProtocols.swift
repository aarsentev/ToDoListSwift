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
}

// MARK: - View Protocol
protocol ToDoListViewProtocol: AnyObject {
    var presenter: ToDoListPresenterProtocol? { get set }
}

// MARK: - Interactor Output Protocol
protocol ToDoListInteractorOutputProtocol: AnyObject {
    func didLoadTodos(_ todos: [ToDoEntity])
    func didSearchTodos(_ todos: [ToDoEntity])
    func didFailWithError(_ error: Error)
}

// MARK: - Interactor Input Protocol
protocol ToDoListInteractorInputProtocol: AnyObject {
    var presenter: ToDoListInteractorOutputProtocol? { get set }
    
    func loadTodos()
    func searchTodos(query: String)
}

// MARK: - Router Protocol
protocol ToDoListRouterProtocol: AnyObject {
    // Navigation methods will be added later
}

