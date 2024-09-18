//
//  NewItemViewModel.swift
//  TutApp
//
//  Created by Vrinda Joshi on 07/08/2024.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation
import UserNotifications

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
        let newItem = ToDoItem(id: newID,
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
            .setData(newItem.asDictionary()) { error in
                if let error = error {
                    print("Error saving item: \(error)")
                } else {
                    print("Successfully saved item: \(newItem)")
                    // Schedule a notification 30 minutes before the due date
                    self.scheduleTaskNotification(task: newItem)
                }
            }
                
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
    
    func scheduleTaskNotification(task: ToDoItem) {
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

