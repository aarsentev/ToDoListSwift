//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Alex Arsentev on 2025-12-04.
//

import SwiftUI

struct ToDoListView: View {
    @StateObject var presenter: ToDoListPresenter
    
    var body: some View {
        NavigationStack {
            Group {
                if presenter.isLoading {
                    ProgressView("Загружаем задачи...")
                } else if presenter.todos.isEmpty {
                    EmptyStateView()
                } else {
                    List {
                        ForEach(presenter.todos) { todo in
                            ToDoRowView(
                                todo: todo,
                                onToggleCompleted: {
                                    presenter.toggleTodoCompleted(todo)
                                }
                            )
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.visible)
                            .contextMenu {
                                Button {
                                } label: {
                                    Label("Редактировать", systemImage: "pencil")
                                }
                                
                                Button {
                                } label: {
                                    Label("Поделиться", systemImage: "square.and.arrow.up")
                                }
                                
                                Button(role: .destructive) {
                                    presenter.deleteTodo(todo)
                                } label: {
                                    Label("Удалить", systemImage: "trash")
                                }
                            } preview: {
                                ToDoRowView(
                                    todo: todo,
                                    onToggleCompleted: {},
                                    showCompletionButton: false
                                )
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .scrollIndicators(.hidden)
            .navigationTitle("Задачи")
            .searchable(
                text: $presenter.searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Поиск"
            )
            .safeAreaInset(edge: .bottom) {
                BottomBarView(
                    count: presenter.todos.count,
                    addAction: {
                    }
                )
            }
            .alert(
                "Error",
                isPresented: .constant(presenter.errorMessage != nil)
            ) {
                Button("OK") {
                    presenter.errorMessage = nil
                }
            } message: {
                Text(presenter.errorMessage ?? "")
            }
        }
        .onChange(of: presenter.searchText) {
            presenter.searchTextDidChange()
        }
        .onAppear {
            presenter.viewDidLoad()
        }
    }
}
