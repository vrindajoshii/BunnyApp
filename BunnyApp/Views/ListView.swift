//
//  ItemsView.swift
//  TutApp
//
//  Created by Vrinda Joshi on 07/08/2024.
//
import Firebase
import FirebaseFirestore
import SwiftUI

struct ItemsView: View {
    @StateObject var viewModel: ListViewModel
    @FirestoreQuery var items: [ToDoItem]

    init(userId: String) {
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/todos")
        self._viewModel = StateObject(wrappedValue: ListViewModel(userId: userId))
    }

    var body: some View {
        NavigationView {
            VStack {
                List(items) { item in
                    SingleItemView(item: item, userId: viewModel.userId) // Pass userId
                        .swipeActions {
                            Button("Delete") {
                                viewModel.delete(item: item)
                            }
                            .tint(.red)
                        }
                }
            }
            .navigationTitle("To Do List")
            .toolbar {
                Button {
                    viewModel.showingNewItemView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingNewItemView) {
                NewItemView(newItemPresented: $viewModel.showingNewItemView)
            }
        }
    }
}
