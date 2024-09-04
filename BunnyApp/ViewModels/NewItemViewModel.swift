//
//  NewItemViewModel.swift
//  TutApp
//
//  Created by Vrinda Joshi on 07/08/2024.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation
class NewItemViewModel: ObservableObject{
    
    @Published var title = ""
    @Published var dueDate = Date()
    @Published var showAlert = false
    
    init(){}
    
    func save(){
        guard canSave else{
            return
        }
        
        //get current user id - we know user is signed in at this point
        guard let uID = Auth.auth().currentUser?.uid else{
            return
        }
        
        let newID = UUID().uuidString
        
        //create model
        let newItem = ToDoListItem(id: newID,
                                   title: title,
                                   dueDate: dueDate.timeIntervalSince1970,
                                   createdDate: Date().timeIntervalSince1970,
                                   isDone: false)
        
        
        //save model to db as a subcollection of the current user so need current user's id too
        let db = Firestore.firestore() //instance of our db
        
        //how we gonna save a new todolist item
        
        db.collection("users")
            .document(uID)
            .collection("todos")
            .document(newID) //new model id
            .setData(newItem.asDictionary()) //dictionary
        
        
                
    }
    
    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        guard dueDate >= Date().addingTimeInterval(-86400) else {
            return false
        }
        
        return true
    }
    
}

