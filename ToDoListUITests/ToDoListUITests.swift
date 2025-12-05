//
//  ToDoListUITests.swift
//  ToDoListUITests
//
//  Created by Alex Arsentev on 2025-12-05.
//

import XCTest

final class ToDoListUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testAppLaunches() {
        XCTAssertTrue(app.exists)
    }
    
    func testSearchBarExists() {
        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.exists)
    }
    
    func testCanTapSearchBar() {
        let searchField = app.searchFields.firstMatch
        searchField.tap()
        XCTAssertTrue(searchField.exists)
    }
}
