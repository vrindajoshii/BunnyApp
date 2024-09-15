import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct EditItemView: View {
    @Binding var isPresented: Bool
    @State var title: String
    @State var dueDate: Date
    
    let item: ToDoItem
    let userId: String
    
    // Add state for showing the alert
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                DatePicker("Due Date", selection: $dueDate)
                    .datePickerStyle(GraphicalDatePickerStyle())
                
                Button("Save") {
                    validateAndSave()
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
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Invalid Due Date"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    /// Validate the due date before saving changes
    private func validateAndSave() {
        let currentDate = Date()
        
        // Check if the selected due date is earlier than the current date
       if dueDate < currentDate {
            alertMessage = "The due date cannot be earlier than the current date and time."
            showAlert = true
        } else {
            saveChanges()
        }
    }
    
    /// Save changes to Firestore
    private func saveChanges() {
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(item.id)
            .updateData([
                "title": title,
                "dueDate": dueDate.timeIntervalSince1970
            ]) { error in
                if let error = error {
                    print("Error updating document: \(error)")
                } else {
                    print("Document successfully updated!")
                    isPresented = false
                }
            }
    }
}

#Preview {
    EditItemView(isPresented: .constant(true),
                 title: "Edit item",
                 dueDate: Date(),
                 item: ToDoItem(id: "123", title: "Sample", dueDate: Date().timeIntervalSince1970, createdDate: Date().timeIntervalSince1970, isDone: false),
                 userId: "EwYahTfkkKTjxyBbW55UhNPUIdJ3")
}
