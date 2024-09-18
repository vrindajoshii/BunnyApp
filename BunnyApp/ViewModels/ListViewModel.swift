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
    func delete(item: ToDoItem){
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(item.id)
            .delete() { error in
                if let error = error {
                    print("Error updating task: \(error)")
                } else {
                    self.cancelTaskNotification(task: item)
                }
            }
    }
    
    func cancelTaskNotification(task: ToDoItem) {
        // Get the identifier for the notification (usually the task ID)
        let notificationIdentifier = task.id ?? UUID().uuidString

        // Fetch all pending notification requests
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            // Check if the notification for the task exists
            let notificationExists = requests.contains { $0.identifier == notificationIdentifier }

            // If the notification exists, cancel it
            if notificationExists {
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notificationIdentifier])
                print("Notification for task \"\(task.title)\" cancelled.")
            } else {
                print("No notification found for task \"\(task.title)\", so no cancellation was made.")
            }
        }
    }
    
}
