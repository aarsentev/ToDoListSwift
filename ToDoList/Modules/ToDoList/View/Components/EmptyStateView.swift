//
//  EmptyStateView.swift
//  ToDoList
//
//  Created by Alex Arsentev on 2025-12-04.
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "checklist")
                .font(.system(size: 60))
                .foregroundColor(.gray.opacity(0.5))
            
            Text("У вас нет задач")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Ваши задачи появятся здесь")
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

#Preview {
    EmptyStateView()
}
