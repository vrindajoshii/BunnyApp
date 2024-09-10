//
//  RegisterView.swift
//  TutApp
//
//  Created by Vrinda Joshi on 07/08/2024.
//

import SwiftUI

struct RegisterView: View {
    
    
    @StateObject var viewModel = RegisterViewModel()

    
    var body: some View {
        VStack{
            //Header
            HeaderView(title:"Register",
                       subtitle:"Let's get started!",
                       angle: -10,
                       background:Color("RegRect"))
            
            Form{
                TextField("Full Name", text: $viewModel.name)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled()

                TextField("Email Address", text: $viewModel.email)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                TLButton(title: "Create Account", background: .green) {
                    //attempt registration
                    viewModel.register()
                }
                
             
            }
            .offset(y:-50)
            
            
            
         Spacer()

        }
        
        
        
        
        
        
        
    }
}

#Preview {
    RegisterView()
}
