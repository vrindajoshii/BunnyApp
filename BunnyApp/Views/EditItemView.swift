import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct EditItemView: View {
    @Binding var isPresented: Bool
    
    let item: ToDoItem
    let userId: String
    
    @StateObject var viewModel = EditItemViewModel()

    // Add state for showing the alert
    @State private var showAlert = false

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $viewModel.title)
                DatePicker("Due Date", selection: $viewModel.dueDate)
                    .datePickerStyle(GraphicalDatePickerStyle())
                
                Button("Save") {
                    viewModel.validateAndSave(item: item, userId: userId)
                    isPresented = false
                }
            }
            .navigationTitle("Edit Item")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
            }
            // Attach alert
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Invalid Due Date"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}
