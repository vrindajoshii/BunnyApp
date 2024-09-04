//
//  ItemsView.swift
//  TutApp
//
//  Created by Vrinda Joshi on 07/08/2024.
//

import FirebaseFirestoreSwift
import SwiftUI

struct ItemsView: View {
    
    @StateObject var viewModel = ListViewModel()
    @FirestoreQuery var items : [ToDoItem]
    
    
    init(userId: String){
        //users/<id>/todos/entries
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/todos")
    }
    
    var body: some View {
        
        NavigationView{
            VStack{
                
            }
            .navigationTitle("To Do List")
            .toolbar{
                Button{
                    //action
                    viewModel.showingNewItemView = true
                    
                }label:{
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingNewItemView){
                
                NewItemView(newItemPresented: $viewModel.showingNewItemView)
            }
            
        }
    }
}

#Preview {
    ItemsView(userId: "")
}
