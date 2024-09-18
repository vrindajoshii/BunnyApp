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
            .setData(itemCopy.asDictionary()) { error in
                if let error = error {
                    print("Error updating task: \(error)")
                } else {
                    // If the task is marked as done, cancel the notification
                    if itemCopy.isDone {
                        self.cancelTaskNotification(task: itemCopy)
                    // if the task is marked as not done but its due date is more than half an hour away, add the notification again
                    } else if (itemCopy.dueDate - 1800) > 1800 {
                        self.rescheduleTaskNotification(task: itemCopy)
                    }
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
    
    // this is a copy-paste of scheduleTaskNotification in NewItemViewModel
    func rescheduleTaskNotification(task: ToDoItem) {
            let content = UNMutableNotificationContent()
            content.title = "Task Reminder"
            content.body = "Your task \"\(task.title)\" is due in 30 minutes."
            content.sound = .default

            // Calculate the time interval (30 minutes before due date)
            let triggerDate = task.dueDate - 1800 // 30 minutes = 1800 seconds
            
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
                    print("Notification scheduled for task: \(task.title)")
                }
            }
        }
    
    
    
}
