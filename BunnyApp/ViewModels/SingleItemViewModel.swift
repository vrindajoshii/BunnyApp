//
//  SingleItemViewModel.swift
//  TutApp
//
//  Created by Vrinda Joshi on 07/08/2024.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation

//single to do list item view (each row in items list)

class SingleItemViewModel: ObservableObject{
    
    init(){}
    
    func toggleIsDone(item: ToDoItem){
        //mark opposite check
        var itemCopy = item
        
        //setting inverse of what it currently is
        itemCopy.setDone(!item.isDone)
        
        //update in db
        guard let uid = Auth.auth().currentUser?.uid else{
            return
        }
        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("todos")
            .document(itemCopy.id)
            .setData(itemCopy.asDictionary())
    }
}
