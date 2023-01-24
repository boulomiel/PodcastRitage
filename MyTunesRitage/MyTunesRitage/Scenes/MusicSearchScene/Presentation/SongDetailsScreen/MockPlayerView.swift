//
//  MockPlayerView.swift
//  MyTunesRitage
//
//  Created by Ruben Mimoun on 24/01/2023.
//

import SwiftUI

struct MockPlayerView: View {
    var body: some View {
        VStack{
            Divider()
                .frame(height: 5)
                .overlay(.white.opacity(0.4))
                .padding(.horizontal)
            
            HStack{
                IconView(
                    systemName: "backward.fill",
                    scale:0.6,
                    color :.white.opacity(0.3)
                )
                Button {
                    
                } label: {
                    IconView(systemName: "play.fill", scale:0.6)
                }
                IconView(
                    systemName: "forward.fill",
                    scale:0.6,
                    color :.white.opacity(0.3)
                )
            }
            .padding(.top)

        }
        .frame(height: 100)
    }
}

struct MockPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        MockPlayerView()
    }
}
