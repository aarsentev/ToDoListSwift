//
//  ToDoListPresenter.swift
//  ToDoList
//
//  Created by Alex Arsentev on 2025-12-04.
//

import Foundation

final class ToDoListPresenter: ToDoListPresenterProtocol, ObservableObject {
    
    @Published var todos: [ToDoEntity] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    var interactor: ToDoListInteractorProtocol?
    var router: ToDoListRouterProtocol?
    
    func viewDidLoad() {
        isLoading = true
        interactor?.loadToDos { [weak self] result in
            switch result {
            case .success(let todos):
                self?.didLoadToDos(todos)
            case .failure(let error):
                self?.didFailWithError(error)
            }
        }
    }
    
    func searchTextDidChange() {
        isLoading = true
        interactor?.searchToDos(
            query: searchText
        ) { [weak self] result in
            switch result {
            case .success(let todos):
                self?.didSearchToDos(todos)
            case .failure(let error):
                self?.didFailWithError(error)
            }
        }
    }
    
    func didLoadToDos(_ todos: [ToDoEntity]) {
        self.todos = todos
        self.isLoading = false
    }
    
    func didSearchToDos(_ todos: [ToDoEntity]) {
        self.todos = todos
        self.isLoading = false
    }
    
    func didFailWithError(_ error: any Error) {
        self.isLoading = false
        self.errorMessage = error.localizedDescription
    }
    
    
}
