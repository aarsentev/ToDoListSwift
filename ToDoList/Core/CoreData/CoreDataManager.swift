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
}
