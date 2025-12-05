//
//  AddEditToDoView.swift
//  ToDoList
//
//  Created by Alex Arsentev on 2025-12-05.
//

import SwiftUI

struct AddEditToDoView: View {
    @StateObject var presenter: AddEditToDoPresenter
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text(presenter.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text(presenter.dateText)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
            .padding(.top, 8)
            
            TextEditor(text: $presenter.text)
                .font(.body)
                .padding(.horizontal, 8)
                .scrollContentBackground(.hidden)
            
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .tint(.yellow)
        .alert(
            "Ошибка",
            isPresented: .constant(presenter.errorMessage != nil)
        ) {
            Button("OK") {
                presenter.errorMessage = nil
            }
        } message: {
            Text(presenter.errorMessage ?? "")
        }
        .onDisappear {
            presenter.saveToDo()
        }
    }
}

