//
//  MusicSearchScreen.swift
//  MyTunesRitage
//
//  Created by Ruben Mimoun on 23/01/2023.
//

import SwiftUI

struct MusicSearchScreen: View {
    
    @State var failure : Failure? = nil
    @State var songs : [Song] = .init()
    @StateObject var musicProvider : MusicSearchProvider = .init()
    
    var body: some View {
        NavigationStack{
            PodcastList(songs: $songs)
            .navigationTitle(Texts.podcast)
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Song.self, destination:selectedTrackDestination)
        }
        .fullScreenCover(item: $failure, content: {ErrorScreen(failure: $0)})
        .animation(.linear, value: songs)
        .searchable(text: $musicProvider.searchableText)
        .preferredColorScheme(.dark)
        .onReceive(musicProvider.onClearInput, perform: onClearInput)
        .onReceive(musicProvider.onErrorReceived, perform: onErrorReceived)
        .onReceive(musicProvider.onSongReceived, perform: onSongReceived)
        .onAppear(perform: onStart)
    }
    
    @ViewBuilder
    private func selectedTrackDestination(_ song : Song) -> some View {
        SongDetailsScreen(song: song)
            .navigationTitle(song.trackName)
    }
             
    private func onStart() {
        musicProvider.start()
    }
    
    private func onClearInput() {
        songs = []
    }
    
    private func onErrorReceived(_ error : Failure) {
        self.failure = error
    }
    
    private func onSongReceived(_ song : Song) {
        self.songs.append(song)
    }
}

struct MusicSearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        MusicSearchScreen()
    }
}
