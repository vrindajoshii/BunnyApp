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
                HeaderView(title:"BusyBunny",
                           subtitle:"Hop into productivity",
                           angle: 10,
                           background:Color("LoginRect")
                        )
             
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
                    TLButton(title: "Log In", background: .mint) {
                        //attempt login
                        viewModel.login()
                    }
                    .padding()

                }
                .offset(y:-50)
                
                //Create Account
                
                VStack{
                    Text("New around here?")
                        .foregroundColor(.mint)
                    //Show registration link
                    NavigationLink("Create an Account",
                                   destination: RegisterView())
                    .foregroundColor(.mint)

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
