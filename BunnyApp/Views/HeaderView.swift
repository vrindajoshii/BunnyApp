//
//  HeaderView.swift
//  TutApp
//
//  Created by Vrinda Joshi on 19/08/2024.
//

import SwiftUI

struct HeaderView: View {
    
    let title: String
    let subtitle: String
    let angle: Double
    let background: Color
    var body: some View {
        //want a z stack to put text over
        ZStack{
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(background)
                .rotationEffect(Angle(degrees: angle))
            
            VStack{
                Text(title)
                    .font(.system(size: 50))
                    .foregroundColor(.white)
                    .bold()
                Text(subtitle)
                    .font(.system(size: 30))
                    .foregroundColor(.white)
            }
            .padding(.top,80)
        }
        .frame(width:UIScreen.main.bounds.width*3, height:350)
        .offset(y:-120)
    }
}

#Preview {
    HeaderView(title:"Title",
               subtitle: "Subtitle",
               angle: 15,
               background:.pink)
}
