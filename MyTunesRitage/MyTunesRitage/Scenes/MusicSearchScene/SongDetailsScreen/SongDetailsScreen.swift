//
//  SongDetailsScreen.swift
//  MyTunesRitage
//
//  Created by Ruben Mimoun on 24/01/2023.
//

import SwiftUI

struct SongDetailsScreen: View {
    
    var song : Song
    @State var rotationDegrees : Double = -90
    @State var orientation : UIDeviceOrientation = .portrait
    @Environment(\.dismiss) private var dismiss
    private let background =  LinearGradient(colors: [.gray.opacity(0.9),.gray.opacity(0.5), .gray.opacity(0.2)], startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        ContentDetails()
        .rotation3DEffect(.degrees(rotationDegrees), axis: (x:0,y:1,z:0))
        .animation(.easeIn, value: rotationDegrees)
        .background(background)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: NavBackButton(backType: .navback, dismiss: self.dismiss))
        .onAppear{ rotationDegrees = 0 }
    }
    

    
    @ViewBuilder
    func ContentDetails() -> some View {
        VStack{
            LoadedImage(url: song.image)
                .frame(width: 300, height: 300)
                .overlay(Rectangle()
                    .stroke(lineWidth: 0.5)
                    .foregroundColor(.white))
                .shadow(radius: 8.0)
                SongInfoView(song: song)
                    .padding(.vertical)
                MockPlayerView()
            Spacer()
        }
        .padding(.top, 60)
    }
}

struct SongDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SongDetailsScreen(
                song: .mock
            )
            .preferredColorScheme(.dark)
        }
    }
}
