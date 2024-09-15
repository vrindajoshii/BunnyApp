import SwiftUI

struct SingleItemView: View {
    @StateObject var viewModel = SingleItemViewModel()
    @State private var isEditing = false
    let item: ToDoItem
    let userId: String

    var body: some View {
        HStack {
            // Toggle done button
            Button {
                viewModel.toggleIsDone(item: item)
            } label: {
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(Color.blue)
            }
            .buttonStyle(PlainButtonStyle())

            // Content
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.body)

                HStack {
                    // Display the due date
                    Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                        .font(.footnote)
                        .foregroundColor(Color(.secondaryLabel))

                    // Display "Overdue" if the due date has passed
                    if isOverdue(dueDate: item.dueDate) && !item.isDone {
                        Text("Overdue")
                            .font(.footnote)
                            .foregroundColor(.red)
                            .bold()
                    }
                }
            }
            Spacer()

            // Edit button
            Button {
                isEditing = true
            } label: {
                Image(systemName: "pencil")
                    .foregroundColor(.green)
            }
            .buttonStyle(PlainButtonStyle())
            .sheet(isPresented: $isEditing) {
                EditItemView(isPresented: $isEditing, title: item.title, dueDate: Date(timeIntervalSince1970: item.dueDate), item: item, userId: userId)
            }
        }
        .contentShape(Rectangle())
    }

    /// Checks if the due date has passed
    private func isOverdue(dueDate: TimeInterval) -> Bool {
        let currentDate = Date()
        let dueDateAsDate = Date(timeIntervalSince1970: dueDate)
        return dueDateAsDate < currentDate
    }
}

#Preview {
    SingleItemView(item: .init(id: "123",
                              title: "Get milk",
                              dueDate: Date().addingTimeInterval(-3600).timeIntervalSince1970, // 1 hour in the past
                              createdDate: Date().timeIntervalSince1970,
                              isDone: false),
                   userId: "EwYahTfkkKTjxyBbW55UhNPUIdJ3")
}
