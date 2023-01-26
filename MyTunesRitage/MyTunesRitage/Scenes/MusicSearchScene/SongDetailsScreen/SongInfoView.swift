//
//  SongInfoView.swift
//  MyTunesRitage
//
//  Created by Ruben Mimoun on 24/01/2023.
//

import SwiftUI

struct SongInfoView: View {
    
    var song : Song
    
    var body: some View {
        VStack{
            Text(song.trackName)
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .leading)
                .bold()
            Text(song.artistName)
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
                .bold()
            Text(song.releaseDate.date())
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.caption)
        }
        .padding(.horizontal)
    }
}

struct SongInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SongInfoView(song: .mock)
            .preferredColorScheme(.dark)
    }
}
