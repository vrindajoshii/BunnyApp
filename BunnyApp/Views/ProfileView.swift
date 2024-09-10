//
//  ProfileView.swift
//  TutApp
//
//  Created by Vrinda Joshi on 07/08/2024.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel = ProfileViewModel()
    var body: some View {
        
        NavigationView{
            VStack{
                
                if let user = viewModel.user{
                    profile(user: user)
                }else {
                    Text("Loading Profile ... ")
                }
                
            }
            .navigationTitle("Profile")
        }
        .onAppear{
            viewModel.fetchUser()
        }
    }
    
    //view builder instead to make the body look cleaner
    @ViewBuilder
    func profile(user: User) -> some View{
        //avatar
        Image(systemName: "person.circle")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            .frame(width:125, height:125)
            .padding()
        
        //info: name, email, member since
        VStack(alignment: .leading){
            HStack{
                Text("Name: ")
                    .bold()
                Text(user.name)
            }
            .padding()
            
            HStack{
                Text("Email: ")
                    .bold()
                Text(user.email)
            }
            .padding()
            HStack{
                Text("Member Since: ")
                    .bold()
                Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
            }
            .padding()
            
        }
        .padding()
        
        //sign out
        Button("Log Out"){
            viewModel.logOut()
        }
        .tint(.red)
        .padding()
        
        Spacer()
    }
    
    
    
}

#Preview {
    ProfileView()
}
