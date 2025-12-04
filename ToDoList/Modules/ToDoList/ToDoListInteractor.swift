//
//  ToDoListInteractor.swift
//  ToDoList
//
//  Created by Alex Arsentev on 2025-12-04.
//

import Foundation

final class ToDoListInteractor: ToDoListInteractorInputProtocol {
    weak var presenter: ToDoListInteractorOutputProtocol?
    
    private let coreDataManager: CoreDataManager
    private let apiService: ToDoAPIService
    
    init(
        coreDataManager: CoreDataManager = .shared,
        apiService: ToDoAPIService = .shared
    ) {
        self.coreDataManager = coreDataManager
        self.apiService = apiService
    }
    
    func loadToDos() {
        checkIfFirstRun()
        
        coreDataManager.fetchAllTodos { [weak self] result in
            switch result {
            case .success(let todos):
                self?.presenter?.didLoadToDos(todos)
            case .failure(let error):
                self?.presenter?.didFailWithError(error)
            }
        }
    }
    
    func searchToDos(query: String) {
        if query.isEmpty {
            loadToDos()
            return
        }
        
        coreDataManager.searchTodos(query: query) { [weak self] result in
            switch result {
            case .success(let todos):
                self?.presenter?.didSearchToDos(todos)
            case .failure(let error):
                self?.presenter?.didFailWithError(error)
            }
        }
    }
    
    private func checkIfFirstRun() {
        let defaults = UserDefaults.standard
        let key = AppConfiguration.UserDefaultsKeys.isFirstLaunchCompleted
        
        guard !defaults.bool(forKey: key) else { return }
        
        apiService.fetchTodos { [weak self] result in
            switch result {
            case .success(let todos):
                self?.coreDataManager.saveToDos(todos) { _ in
                    defaults.set(true, forKey: key)
                }
            case .failure(let error):
                self?.presenter?.didFailWithError(error)
            }
        }
    }
}
