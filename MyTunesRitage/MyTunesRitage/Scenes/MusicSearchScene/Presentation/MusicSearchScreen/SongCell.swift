//
//  SongCell.swift
//  MyTunesRitage
//
//  Created by Ruben Mimoun on 23/01/2023.
//

import SwiftUI

struct SongCell: View {
    
    var song : Song
    @State var offsetX : CGFloat = 800
    
    var body: some View {
        HStack{
            Thumbnail(song.image)
            Content(song.trackName,song.artistName)
        }
        .animation(.spring().speed(0.8), value: offsetX)
        .onAppear{
            offsetX = 0
        }
    }
    
    @ViewBuilder
    func Thumbnail(_ url : String) -> some View {
        LoadedImage(url: url)
            .frame(width: 90, height: 90)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.trailing, 8)
    }
    
    @ViewBuilder
    func Content(_ trackName : String,_ artistName : String) -> some View {
        VStack{
            Text(trackName)
                .cellStyle(font: .title3)
            
            Text(artistName)
                .cellStyle(font: .caption2)
        }
        .offset(x:offsetX)
    }
}

struct SongCell_Previews: PreviewProvider {
    static var previews: some View {
        SongCell(song: .init(trackId: 0, artistName: "", trackName: "", image: "", releaseDate: ""))
    }
}
