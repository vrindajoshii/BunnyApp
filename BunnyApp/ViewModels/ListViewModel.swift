//
//  ItemsViewModel.swift
//  TutApp
//
//  Created by Vrinda Joshi on 07/08/2024.
//

import Foundation
import FirebaseFirestore

//list of items view - primary tabe
class ListViewModel: ObservableObject{
    
    @Published var showingNewItemView = false //when first launches dont want it shown right away
    
    let userId : String
    
    init(userId: String){
        self.userId = userId
    }
    
    /// Delete to do list item
    /// - Parameter id: Item id to delete
    func delete(id: String){
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(id)
            .delete()
    }
    
  
    
}
