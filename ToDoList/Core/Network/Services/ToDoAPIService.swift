//
//  ToDoAPIService.swift
//  ToDoList
//
//  Created by Alex Arsentev on 2025-12-04.
//

import Foundation

final class ToDoAPIService {
    static let shared = ToDoAPIService()
    private let networkManager: NetworkManager
    
    private init(networkManager: NetworkManager = .shared) {
        self.networkManager = networkManager
    }
    
    func fetchTodos(completion: @escaping (Result<[ToDoEntity], NetworkError>) -> Void) {
        networkManager.get(url: AppConfiguration.API.todosFullURL) { (result: Result<TodosResponse, NetworkError>) in
            switch result {
            case .success(let response):
                let entities = response.todos.map { $0.toEntity() }
                completion(.success(entities))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
