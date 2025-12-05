//
//  AddEditToDoPresenter.swift
//  ToDoList
//
//  Created by Alex Arsentev on 2025-12-05.
//

import Foundation

final class AddEditToDoPresenter: AddEditToDoPresenterProtocol, ObservableObject {
    
    @Published var title: String
    @Published var dateText: String
    @Published var text: String
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    var interactor: AddEditToDoInteractorProtocol?
    var router: AddEditToDoRouterProtocol?
    
    private let todo: ToDoEntity?
    private let isEditMode: Bool
    private var onSave: (() -> Void)?
    
    init(todo: ToDoEntity?, onSave: (() -> Void)? = nil) {
        self.todo = todo
        self.isEditMode = todo != nil
        self.onSave = onSave
        
        if let todo = todo {
            self.title = "Задача \(todo.id)"
            self.dateText = DateFormatter.todoDateFormatter.string(from: todo.createdDate)
            self.text = todo.todo
        } else {
            self.title = "Новая задача"
            self.dateText = DateFormatter.todoDateFormatter.string(from: Date())
            self.text = ""
        }
    }
    
    func viewDidLoad() {
    }
    
    func saveToDo() {
        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            router?.dismiss()
            return
        }
        
        isLoading = true
        
        // Edit mode
        if let existingTodo = todo {
            var updatedTodo = existingTodo
            updatedTodo.todo = text
            
            interactor?.saveToDo(updatedTodo) { [weak self] result in
                switch result {
                case .success:
                    self?.didSaveToDo()
                case .failure(let error):
                    self?.didFailWithError(error)
                }
            }
        } else {
            // Add mode
            interactor?.createToDo(text: text) { [weak self] result in
                switch result {
                case .success:
                    self?.didSaveToDo()
                case .failure(let error):
                    self?.didFailWithError(error)
                }
            }
        }
    }
    
    func didSaveToDo() {
        isLoading = false
        onSave?()
        router?.dismiss()
    }
    
    func didFailWithError(_ error: Error) {
        isLoading = false
        errorMessage = error.localizedDescription
    }
}

