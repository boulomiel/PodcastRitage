//
//  PodcastList.swift
//  MyTunesRitage
//
//  Created by Ruben Mimoun on 24/01/2023.
//

import SwiftUI

struct PodcastList: View {
    @Binding var songs : [Song]

    var body: some View {
        List{
            ListContent(songs: songs)
        }
    }
    
    @ViewBuilder
    func ListContent(songs : [Song]) -> some View{
        if songs.isEmpty{
            ForEach(0..<2){_ in
                SongCell(song: .mock)
                    .redacted(reason: .placeholder)
            }
        }else{
            ForEach(songs, id:\.id) { song in
                NavigationLink(value: song) {
                    SongCell(song: song)
                }
            }
        }
    }
}

struct PodcastList_Previews: PreviewProvider {
    static var previews: some View {
        PodcastList(
            songs: .constant([])
        )
    }
}
