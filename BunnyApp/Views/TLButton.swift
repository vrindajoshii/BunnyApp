//
//  TLButton.swift
//  TutApp
//
//  Created by Vrinda Joshi on 19/08/2024.
//

import SwiftUI




struct TLButton: View {

    let title : String
    let background : Color
    let action: () -> Void
    
    var body: some View {
        Button{
            //Call that Action
            action()
            
        }label: {
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(background)
                
                Text(title)
                    .foregroundColor(.white)
                    .bold()
            }
        }
    }
}

#Preview {
    TLButton(title: "Value",
             background: .green){
        //action
    }
}
