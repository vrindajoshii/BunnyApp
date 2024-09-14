//
//  CalendarView.swift
//  BunnyApp
//
//  Created by sahars03 on 12/09/2024.
//

import FirebaseFirestore
import SwiftUI

struct CalendarView: View {
    
    @StateObject var viewModel: CalendarViewViewModel
    @FirestoreQuery var items: [ToDoItem]
    @State var selectedDate = Date()
            
    init(userId: String) {
//        self.userId = userId
        let startOfDay = Calendar.current.startOfDay(for: Date())
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
        
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/todos",
                                     predicates: [
                                         .whereField("dueDate", isGreaterThanOrEqualTo: startOfDay.timeIntervalSince1970),
                                         .whereField("dueDate", isLessThanOrEqualTo: endOfDay.timeIntervalSince1970)
                                     ])
        self._viewModel = StateObject(wrappedValue: CalendarViewViewModel(userId: userId))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                DatePicker(
                    "Due Date",
                    selection: $selectedDate,
                    displayedComponents: .date // Restrict to date only
                )
                .onChange(of: selectedDate) {
                    viewModel.eventsOnDay(thisDay: selectedDate)
                }
                .datePickerStyle(GraphicalDatePickerStyle())
                
                List(viewModel.items) { item in
                    listView(item: item)
                }
                .listStyle(PlainListStyle())
                
            }
            .navigationTitle("Calendar")
            
        }
    }
    
    @ViewBuilder
    func listView(item: ToDoItem) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.body)
                Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                    .font(.footnote)
                    .foregroundColor(Color(.secondaryLabel))
            }
        }
    }
}

