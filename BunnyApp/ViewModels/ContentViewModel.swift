//
//  ContentViewModel.swift
//  BunnyApp
//
//  Created by Vrinda Joshi on 01/09/2024.
//



import Foundation
import FirebaseAuth

class ContentViewModel: ObservableObject{
    
    @Published var currentUserId: String = ""
    private var handler: AuthStateDidChangeListenerHandle?
    
    init(){
        
        //handy dandy listener here for logout it helps
        self.handler = Auth.auth().addStateDidChangeListener{[weak self] _, user in
            DispatchQueue.main.async{
                self?.currentUserId = user?.uid ?? ""

            }
            
        }

    }
    
    public var isSignedIn: Bool{
        return Auth.auth().currentUser != nil


    }
}
