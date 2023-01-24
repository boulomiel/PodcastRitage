//
//  ErrorScreen.swift
//  MyTunesRitage
//
//  Created by Ruben Mimoun on 24/01/2023.
//

import SwiftUI

struct ErrorScreen: View {
    @Environment(\.dismiss) var dismiss

    var failure : Failure
    @State var scale : CGFloat = 0
    @State var titleOffset : CGFloat = 800
    
    private let background =  LinearGradient(
        colors: [.red.opacity(0.9),
                 .red.opacity(0.5),
                 .red.opacity(0.2)],
                startPoint: .top,
        endPoint: .bottom)
    
    var body: some View {
        NavigationStack{
            VStack{
                Text(failure.title)
                    .foregroundColor(.white)
                    .font(.title)
                    .bold()
                    .offset(x:titleOffset)

                IconView(systemName: "xmark.circle.fill",
                         scale : 0.6,
                         color : .red)
                .scaleEffect(scale)
                
                Text(failure.reason)
                    .foregroundColor(.white)
                    .font(.title2)
                    .bold()
                    .offset(x:-titleOffset)
                
                Spacer()
            }
            .padding(.top, 40)
            .toolbar{
                ToolbarItem(placement : .navigationBarLeading){
                    NavBackButton(backType: .close, dismiss: dismiss)
                }
            }
            .animation(.spring(), value: titleOffset)
            .animation(.spring(), value: scale)
            .onAppear{
                titleOffset =  1
                scale = 1
            }
            .background(background)
            .background(Color.black)
        }
    }
}

struct ErrorScreen_Previews: PreviewProvider {
    static var previews: some View {
        ErrorScreen(failure: .mock)
    }
}
