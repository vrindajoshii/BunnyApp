//
//  RegisterViewModel.swift
//  TutApp
//
//  Created by Vrinda Joshi on 07/08/2024.
//
import FirebaseFirestore
import Foundation
import FirebaseAuth


class RegisterViewModel: ObservableObject{
    
    
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    
    init(){}
    
    func register(){
        guard validate() else{
            return
        }
        
        //create user
        Auth.auth().createUser(withEmail: email, password: password){ [weak self]
            result, error in
            guard let userID = result?.user.uid else{
                return
            }
            self?.insertUserRecord(id: userID)
        }
    }
    
    private func insertUserRecord(id:String){
        
        let newUser = User(id: id,
                           name:name,
                           email:email,
                           joined:Date().timeIntervalSince1970)
        
        //made new user object now insert into db
        
        let db = Firestore.firestore()
        //records are stored in collections and docs
        
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
        
    }
    
    private func validate() -> Bool{
        
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else{
            return false
        }
        
        guard email.contains("@") && email.contains(".") else{
            return false
        }
        
        guard password.count >= 6 else{
            return false
        }
        
        return true
    }
    
}
