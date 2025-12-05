//
//  DateFormatterExtensions.swift
//  ToDoList
//
//  Created by Alex Arsentev on 2025-12-05.
//

import Foundation

extension DateFormatter {
    static let todoDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        return formatter
    }()
}

