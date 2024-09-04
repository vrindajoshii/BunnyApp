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
                
            }
            .navigationTitle("Profile")
        }    }
}

#Preview {
    ProfileView()
}
