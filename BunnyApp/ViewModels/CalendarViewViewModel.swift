//
//  CalendarViewViewModel.swift
//  BunnyApp
//
//  Created by Dr M Sohail on 12/09/2024.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class CalendarViewViewModel: ObservableObject {

    @Published var currentDate = Date()
    
    init() {}
    

    func eventsOnDay(thisDay: Date) {
        // goes into the database and checks if there are any todo list items scheduled for the day
        // do we need to save events for different days for a user in another place
        // we would need to store this information at the same time as when the user adds and item (so edit and delete would have to work on this too)
    }
    
}
