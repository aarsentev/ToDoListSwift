//
//  BottomBarView.swift
//  ToDoList
//
//  Created by Alex Arsentev on 2025-12-04.
//

import SwiftUI

struct BottomBarView: View {
    let count: Int
    let addAction: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            
            Text("\(count) Задач")
                .font(.footnote)
                .foregroundColor(.secondary)
            
            Spacer()
        }
        .overlay(
            HStack {
                Spacer()
                Button(action: addAction) {
                    Image(systemName: "square.and.pencil")
                        .font(.title2)
                        .foregroundColor(.yellow)
                        .padding(.horizontal, 4)
                }
            }
        )
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(
            Color(.systemGray6)
                .ignoresSafeArea(edges: .bottom)
        )
    }
}

#Preview {
    VStack {
        Spacer()
    }
    .safeAreaInset(edge: .bottom) {
        BottomBarView(count: 7, addAction: {})
    }
}
