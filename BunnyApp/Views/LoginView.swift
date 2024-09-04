//
//  LoginView.swift
//  TutApp
//
//  Created by Vrinda Joshi on 07/08/2024.
//

import SwiftUI


struct LoginView: View {
    
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            
            VStack{
                //Header
                HeaderView(title:"To Do List",
                           subtitle:"Get things done",
                           angle: 10,
                           background:.blue)
             
                //Login form
                Form{
                    
                    
                    if  !viewModel.errorMessage.isEmpty{
                        Text(viewModel.errorMessage)
                            .foregroundColor(Color.red)
                    }
                    
                
                    
                    
                    TextField("Email Address", text: $viewModel.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                    
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    
                    //Custom button is a separate view now
                    TLButton(title: "Log In", background: .blue) {
                        //attempt login
                        viewModel.login()
                    }
                    .padding()

                }
                .offset(y:-50)
                
                //Create Account
                
                VStack{
                    Text("New around here?")
                    
                    //Show registration link
                    NavigationLink("Create an Account",
                                   destination: RegisterView())
                }
                .padding(.bottom, 50)
                
                Spacer() //to push the z stack(header) up
            }

                
        }
        
       

    }
}

#Preview {
    LoginView()
}
