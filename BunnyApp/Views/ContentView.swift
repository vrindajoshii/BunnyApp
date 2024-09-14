//
//  ContentView.swift
//  TutApp
//
//  Created by Vrinda Joshi on 07/08/2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    var body: some View {

        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty{
            //signed in
            accountView
        }else{
            LoginView()
        }

    }
    @ViewBuilder
    var accountView: some View {
        TabView{
            ItemsView(userId: viewModel.currentUserId)
                .tabItem { Label("Home", systemImage: "house")
                }
            ProfileView()
                .tabItem { Label("Profile", systemImage: "person.circle")
                }
            CalendarView(userId: viewModel.currentUserId)
                .tabItem { Label("Calendar",
                    systemImage: "calendar")
                }
        }
    }
}

#Preview {
    ContentView()
}
