//
//  SingleItemView.swift
//  TutApp
//
//  Created by Vrinda Joshi on 07/08/2024.
//

import SwiftUI

struct SingleItemView: View {
    
    @StateObject var viewModel = SingleItemViewModel()
    let item: ToDoItem
    
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(item.title)
                    .font(.body)
                Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                    .font(.footnote)
                    .foregroundColor(Color(.secondaryLabel))
            }
            Spacer()
            
            //on rhs want a button
            Button{
                //flip the check mark
                viewModel.toggleIsDone(item: item)
            }label: {
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(Color.blue)
            }
            
            
        }
    }
}

#Preview {
    SingleItemView(item: .init(id: "123",
                              title: "Get milk",
                               dueDate: Date().timeIntervalSince1970,
                               createdDate: Date().timeIntervalSince1970,
                              isDone: true))
}
