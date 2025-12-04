//
//  ToDoListInteractor.swift
//  ToDoList
//
//  Created by Alex Arsentev on 2025-12-04.
//

import Foundation

final class ToDoListInteractor: ToDoListInteractorProtocol {
    
    weak var presenter: (any ToDoListPresenterProtocol)?
    
    private let coreDataManager: CoreDataManager
    private let apiService: ToDoAPIService
    
    init(
        coreDataManager: CoreDataManager = .shared,
        apiService: ToDoAPIService = .shared
    ) {
        self.coreDataManager = coreDataManager
        self.apiService = apiService
    }
    
    func loadToDos(completion: @escaping (Result<[ToDoEntity], Error>) -> Void) {
        checkIfFirstRun { [weak self] in
            self?.coreDataManager.fetchAllTodos(completion: completion)
        }
    }
    
    func searchToDos(query: String, completion: @escaping (Result<[ToDoEntity], Error>) -> Void) {
        if query.isEmpty {
            loadToDos(completion: completion)
            return
        }
        coreDataManager.searchTodos(query: query, completion: completion)
    }
    
    func toggleTodoCompleted(_ todo: ToDoEntity, completion: @escaping (Result<ToDoEntity, Error>) -> Void) {
        var updatedTodo = todo
        updatedTodo.completed.toggle()
        coreDataManager.updateTodo(updatedTodo, completion: completion)
    }
    
    private func checkIfFirstRun(completion: @escaping () -> Void) {
        let defaults = UserDefaults.standard
        let key = AppConfiguration.UserDefaultsKeys.isFirstLaunchCompleted
        
        guard !defaults.bool(forKey: key) else {
            print("[ToDoListInteractor] Not first run, using CoreData")
            completion()
            return
        }
        
        print("[ToDoListInteractor] First run detected, loading from API")
        apiService.fetchTodos { [weak self] result in
            switch result {
            case .success(let todos):
                self?.coreDataManager.saveToDos(todos) { saveResult in
                    switch saveResult {
                    case .success:
                        print("[ToDoListInteractor] Successfully saved todos to CoreData")
                        defaults.set(true, forKey: key)
                        completion()
                    case .failure(let error):
                        print("[ToDoListInteractor] Failed to save: \(error.localizedDescription)")
                        completion()
                    }
                }
            case .failure(let error):
                print("[ToDoListInteractor] API request failed: \(error.localizedDescription)")
                self?.presenter?.didFailWithError(error)
                completion()
            }
        }
    }
}
