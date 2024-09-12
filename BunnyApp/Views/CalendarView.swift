//
//  CalendarView.swift
//  BunnyApp
//
//  Created by Dr M Sohail on 12/09/2024.
//

import SwiftUI

struct CalendarView: View {
    
    @StateObject var viewModel = CalendarViewViewModel()

    var body: some View {
        NavigationView {
            VStack {
                DatePicker(
                    "Due Date",
                    selection: $viewModel.currentDate,
                    displayedComponents: .date // Restrict to date only
                )
                .onChange(of: viewModel.currentDate) {
                    viewModel.eventsOnDay(thisDay: viewModel.currentDate)
                }
                .datePickerStyle(GraphicalDatePickerStyle())
                
                // here we can have code similar to ListView for listing the items under the calendar (without the delete button)
                // do we use singleitemview again or something else
 //               List(items) { item in
 //                   SingleItemView(item: item, userId: viewModel.userId) // Pass userId
//              }
            }
            .navigationTitle("Calendar")
            
        }
    }
}

#Preview {
    CalendarView()
}
