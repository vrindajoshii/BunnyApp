import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct EditItemView: View {
    @Binding var isPresented: Bool
    @State var title: String
    @State var dueDate: Date
    
    let item: ToDoItem
    let userId: String
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                
                Button("Save") {
                    saveChanges()
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
        }
    }
    
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
