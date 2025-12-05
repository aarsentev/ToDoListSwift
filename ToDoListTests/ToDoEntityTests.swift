//
//  ToDoEntityTests.swift
//  ToDoListTests
//
//  Created by Alex Arsentev on 2025-12-05.
//

import XCTest
@testable import ToDoList

final class ToDoEntityTests: XCTestCase {
    
    func testInit_CreatesEntity() {
        let entity = ToDoEntity(id: 1, todo: "Test task")
        
        XCTAssertEqual(entity.id, 1)
        XCTAssertEqual(entity.todo, "Test task")
        XCTAssertFalse(entity.completed)
    }
    
    func testToggleCompleted() {
        var entity = ToDoEntity(id: 1, todo: "Task", completed: false)
        
        entity.completed = true
        
        XCTAssertTrue(entity.completed)
    }
    
    func testUpdateText() {
        var entity = ToDoEntity(id: 1, todo: "Old text")
        
        entity.todo = "New text"
        
        XCTAssertEqual(entity.todo, "New text")
    }
}
