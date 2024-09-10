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
    
    @StateObject var viewModel : ListViewModel
    
    //query that continuously listens for items. @is property wrapper
    @FirestoreQuery var items : [ToDoItem]
    
    
    //observe all the database entries at a particular path
    
    init(userId: String){
        //users/<id>/todos/entries
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/todos"
        )
        self._viewModel = StateObject(
            wrappedValue: ListViewModel(userId: userId)
        )
    }
    
    var body: some View {
        
        NavigationView{
            VStack{
                List(items){
                    item in SingleItemView(item: item)
                    //want to also be able to swipe on the view
                        .swipeActions(){
                            Button("Delete"){
                                viewModel.delete(id: item.id)
                            }
                            .tint(.red)
                        }
                }
                .listStyle(PlainListStyle())
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
    ItemsView(userId: "EwYahTfkkKTjxyBbW55UhNPUIdJ3")
}
