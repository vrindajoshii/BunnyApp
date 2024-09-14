//
//  CalendarViewModel.swift
//  BunnyApp
//
//  Created by sahars03 on 12/09/2024.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class CalendarViewViewModel: ObservableObject {
    @Published var items: [ToDoItem] // Store items fetched from Firestore

    private let userId: String

    init(userId: String) {
        self.userId = userId
        self.items = []
    }
    
    func eventsOnDay(thisDay: Date) {
            let startOfDay = Calendar.current.startOfDay(for: thisDay)
            let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
            
            let db = Firestore.firestore()
            let query = db.collection("users/\(userId)/todos")
                .whereField("dueDate", isGreaterThanOrEqualTo: startOfDay.timeIntervalSince1970)
                .whereField("dueDate", isLessThanOrEqualTo: endOfDay.timeIntervalSince1970)
            
            // Perform the Firestore query
            query.getDocuments { [weak self] snapshot, error in
                if let error = error {
                    print("Error fetching items: \(error)")
                    return
                }
                
                // Handle the documents returned from Firestore
                guard let documents = snapshot?.documents else {
                    print("No documents found")
                    return
                }
                
                // Map documents to ToDoListItem models and assign to the published items array
                self?.items = documents.compactMap { document in
                    try? document.data(as: ToDoItem.self)
                }
            }
        }
}
