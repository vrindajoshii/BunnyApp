//
//  LoginViewModel.swift
//  TutApp
//
//  Created by Vrinda Joshi on 07/08/2024.
//

import Foundation
import FirebaseAuth

//have an object instead of loads of vars in the view itself
//all business logic in here

class LoginViewModel: ObservableObject{
    
    //published property wrapper
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    
    init(){}
    
    func login(){
        
        guard validate() else{
            return
        }
        
        //try login
        
        Auth.auth().signIn(withEmail: email, password: password) //ref to firebase authentication
        
        
        
        
        
    }
    
    
    //returns true or false if we were able to validate
    private func validate() -> Bool{
        
        //reset message
        errorMessage = ""
        
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.trimmingCharacters(in: .whitespaces).isEmpty else{
            
            errorMessage="Please fill in all fields"
            
            return false
            
        }
        
        //email@foo.com
        
        guard email.contains("@") && email.contains(".") else{
            errorMessage = "Please enter valid email."
            return false
        }
        
        
        return true
    }
}
