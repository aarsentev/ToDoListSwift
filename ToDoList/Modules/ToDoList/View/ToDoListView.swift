//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Alex Arsentev on 2025-12-04.
//

import SwiftUI

struct ToDoListView: View {
    @StateObject var presenter: ToDoListPresenter
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
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
                                    navigationPath.append(ToDoListDestination.addEditToDo(todo: todo))
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
                        navigationPath.append(ToDoListDestination.addEditToDo(todo: nil))
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
            .navigationDestination(for: ToDoListDestination.self) { destination in
                switch destination {
                case .addEditToDo(let todo):
                    AddEditToDoBuilder.build(todo: todo)
                }
            }
            .onChange(of: presenter.searchText) {
                presenter.searchTextDidChange()
            }
            .onAppear {
                presenter.viewDidLoad()
            }
            .onReceive(NotificationCenter.default.publisher(for: .toDoDidSave)) { _ in
                presenter.viewDidLoad()
            }
        }
    }
}
