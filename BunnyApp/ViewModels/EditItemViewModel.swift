//
//  EditItemViewModel.swift
//  BunnyApp
//
//  Created by Vrinda Joshi on 11/09/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class EditItemViewModel: ObservableObject{
    
    @Published var title = ""
    @Published var dueDate = Date()
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    init(){}

    func validateAndSave(item: ToDoItem, userId: String) {
        let currentDate = Date()
        
        // Check if the selected due date is earlier than the current date
       if dueDate < currentDate {
            alertMessage = "The due date cannot be earlier than the current date and time."
            showAlert = true
        } else {
            saveChanges(item: item, userId: userId)
        }
    }
    
    func saveChanges(item: ToDoItem, userId: String) {
        var itemCopy = item
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(item.id)
            .updateData([
                "title": self.title,
                "dueDate": self.dueDate.timeIntervalSince1970
            ]) { error in
                if let error = error {
                    print("Error updating document: \(error)")
                } else {
                    print("Document successfully updated!")
                    // cancel the current notification
                    self.cancelOldTaskNotification(task: item)
                    
                    // if the new due date is late enough to have a notification, make a new notification
                    if (self.dueDate.timeIntervalSince1970 - Date().timeIntervalSince1970) > 1800 {
                        self.scheduleEditedTaskNotification(task: item)
                    }
                }
            }
    }
    
    func cancelOldTaskNotification(task: ToDoItem) {
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
    
    // this is a copy-paste of scheduleTaskNotification in NewItemViewModel
    func scheduleEditedTaskNotification(task: ToDoItem) {
            let content = UNMutableNotificationContent()
            content.title = "Task Reminder"
            content.body = "Your task \"\(task.title)\" is due in 30 minutes."
            content.sound = .default

            // Calculate the time interval (30 minutes before due date)
        let triggerDate = self.dueDate.timeIntervalSince1970 - 1800 // 30 minutes = 1800 seconds
            
            // If the trigger time is in the past, don't schedule the notification
            if triggerDate <= Date().timeIntervalSince1970 {
                print("Notification trigger time is in the past. No notification will be scheduled.")
                return
            }
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: triggerDate - Date().timeIntervalSince1970, repeats: false)

            // Create a unique identifier for the notification using the task's ID
            let request = UNNotificationRequest(identifier: task.id ?? UUID().uuidString, content: content, trigger: trigger)

            // Add the notification request to the notification center
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error.localizedDescription)")
                } else {
                    print("Notification rescheduled for task: \(task.title)")
                }
            }
        }
}


