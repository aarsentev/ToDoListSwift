//
//  CoreDataManager.swift
//  ToDoList
//
//  Created by Alex Arsentev on 2025-12-04.
//

import Foundation
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    private let container: NSPersistentContainer
    private let backgroundContext: NSManagedObjectContext
    
    private init() {
        container = NSPersistentContainer(
            name: AppConfiguration.CoreData.containerName
        )
        
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("CoreData failed to load: \(error.localizedDescription)")
            }
        }
        
        backgroundContext = container.newBackgroundContext()
    }
    
    func fetchAllTodos(completion: @escaping (Result<[ToDoEntity], Error>) -> Void) {
        backgroundContext.perform { [weak self] in
            guard let self = self else { return }
            
            let request = NSFetchRequest<ToDoItem>(entityName: "ToDoItem")
            request.sortDescriptors = [NSSortDescriptor(key: "createdDate", ascending: false)]
            
            do {
                let items = try self.backgroundContext.fetch(request)
                let entities = items.compactMap { self.convertToEntity($0) }
                DispatchQueue.main.async {
                    completion(.success(entities))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func searchTodos(query: String, completion: @escaping (Result<[ToDoEntity], Error>) -> Void) {
        backgroundContext.perform { [weak self] in
            guard let self = self else { return }
            
            let request = NSFetchRequest<NSManagedObject>(entityName: "ToDoItem")
            request.predicate = NSPredicate(format: "todo CONTAINS[cd] %@", query)
            request.sortDescriptors = [NSSortDescriptor(key: "createdDate", ascending: false)]
            
            do {
                let items = try self.backgroundContext.fetch(request)
                let entities = items.compactMap { self.convertToEntity($0) }
                DispatchQueue.main.async {
                    completion(.success(entities))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func saveToDos(_ entities: [ToDoEntity], completion: @escaping (Result<Void, Error>) -> Void) {
        backgroundContext.perform { [weak self] in
            guard let self = self else { return }
            
            for entity in entities {
                let item = ToDoItem(context: self.backgroundContext)
                item.id = Int32(entity.id)
                item.todo = entity.todo
                item.completed = entity.completed
                item.userId = Int32(entity.userId)
                item.createdDate = entity.createdDate
            }
            
            do {
                try self.backgroundContext.save()
                DispatchQueue.main.async {
                    completion(.success(()))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    private func convertToEntity(_ item: NSManagedObject) -> ToDoEntity? {
        guard let id = item.value(forKey: "id") as? Int32,
              let todo = item.value(forKey: "todo") as? String,
              let completed = item.value(forKey: "completed") as? Bool,
              let userId = item.value(forKey: "userId") as? Int32,
              let createdDate = item.value(forKey: "createdDate") as? Date else {
            return nil
        }
        
        return ToDoEntity(
            id: Int(id),
            todo: todo,
            completed: completed,
            userId: Int(userId),
            createdDate: createdDate
        )
    }
}
