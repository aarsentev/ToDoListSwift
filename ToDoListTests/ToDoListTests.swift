//
//  ToDoListTests.swift
//  ToDoListTests
//
//  Created by Alex Arsentev on 2025-12-05.
//

import XCTest
@testable import ToDoList

final class ToDoListTests: XCTestCase {

    func testPresenterInitialization() {
        let presenter = ToDoListPresenter()
        
        XCTAssertEqual(presenter.todos.count, 0)
        XCTAssertFalse(presenter.isLoading)
        XCTAssertNil(presenter.errorMessage)
    }
    
    func testAddEditPresenterInitialization_CreateMode() {
        let presenter = AddEditToDoPresenter(todo: nil)
        
        XCTAssertEqual(presenter.title, "Новая задача")
        XCTAssertEqual(presenter.text, "")
    }
    
    func testAddEditPresenterInitialization_EditMode() {
        let todo = ToDoEntity(id: 1, todo: "Test task", completed: false)
        
        let presenter = AddEditToDoPresenter(todo: todo)
        
        XCTAssertEqual(presenter.title, "Задача 1")
        XCTAssertEqual(presenter.text, "Test task")
    }
}
