//
//  SingleItemView.swift
//  TutApp
//
//  Created by Vrinda Joshi on 07/08/2024.
//

import SwiftUI

struct SingleItemView: View {
    @StateObject var viewModel = SingleItemViewModel()
    @State private var isEditing = false
    let item: ToDoItem
    let userId: String
    
    var body: some View {
        HStack {
            // Toggle done button
            Button {
                viewModel.toggleIsDone(item: item)
            } label: {
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(Color.blue)
            }
            .buttonStyle(PlainButtonStyle()) // Ensures it only registers when the circle is tapped
            
            // Content
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.body)
                Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                    .font(.footnote)
                    .foregroundColor(Color(.secondaryLabel))
            }
            .contentShape(Rectangle()) // Prevent taps from triggering unwanted actions
            
            Spacer()
            
            // Edit button
            Button {
                isEditing = true
            } label: {
                Image(systemName: "pencil")
                    .foregroundColor(.green)
            }
            .buttonStyle(PlainButtonStyle()) // Ensures only the pencil icon triggers this
            .sheet(isPresented: $isEditing) {
                EditItemView(isPresented: $isEditing, title: item.title, dueDate: Date(timeIntervalSince1970: item.dueDate), item: item, userId: userId)
            }
        }
        .contentShape(Rectangle()) // Ensure no unexpected interaction on the entire row
    }
}

#Preview {
    SingleItemView(item: .init(id: "123",
                              title: "Get milk",
                               dueDate: Date().timeIntervalSince1970,
                               createdDate: Date().timeIntervalSince1970,
                              isDone: true),
                   userId: "EwYahTfkkKTjxyBbW55UhNPUIdJ3")
}
