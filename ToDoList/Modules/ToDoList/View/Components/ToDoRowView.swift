//
//  ToDoRowView.swift
//  ToDoList
//
//  Created by Alex Arsentev on 2025-12-04.
//

import SwiftUI

struct ToDoRowView: View {
    let todo: ToDoEntity
    let onToggleCompleted: () -> Void
    var showCompletionButton: Bool = true
    
    var body: some View {
        HStack(spacing: 12) {
            if showCompletionButton {
                Button(action: onToggleCompleted) {
                    Circle()
                        .strokeBorder(
                            todo.completed ? Color.yellow : Color.gray.opacity(0.6),
                            lineWidth: 2
                        )
                        .frame(width: 26, height: 26)
                        .overlay {
                            if todo.completed {
                                Image(systemName: "checkmark")
                                    .font(.system(size: 13, weight: .bold))
                                    .foregroundColor(.yellow)
                            }
                        }
                }
                .buttonStyle(.plain)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Задача \(todo.id)")
                    .font(.system(size: 16, weight: .regular))
                    .strikethrough(todo.completed, color: .gray)
                    .foregroundColor(todo.completed ? .gray : .primary)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(todo.todo)
                        .font(.system(size: 12, weight: .regular))
                        .strikethrough(todo.completed, color: .gray)
                        .foregroundColor(todo.completed ? .gray : .primary)
                    
                    Text(DateFormatter.todoDateFormatter.string(from: todo.createdDate))
                        .font(.caption)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .background(Color(.systemBackground))
    }
}

#Preview {
    ToDoRowView(
        todo: ToDoEntity(
            id: 1,
            todo: "Test task",
            completed: true,
            userId: 123
        ),
        onToggleCompleted: {}
    )
    .padding()
}
