//
//  MusicSearchData.swift
//  MyTunesRitage
//
//  Created by Ruben Mimoun on 23/01/2023.
//

import Foundation


enum MusicSearchData {
    
    struct Request {
        var query : String
    }
    
    struct Response {
            
        struct  Success {
            var raw : ItuneItemRaw
        }
        
        struct  Empty {}
        
        struct  Error {
            var raw : APIError
        }
    }
    
    struct ViewModel {
         
        struct Song : Equatable, Identifiable, Hashable {
            var id : UUID = .init()
            var trackId : Int
            var artistName : String
            var trackName : String
            var image : String
            var releaseDate : String
            
            static let mock : Self = .init(trackId: 1,
                                           artistName: "Pikachu",
                                           trackName: "Gotta catch em all",
                                           image: "https://picsum.photos/400",
                                           releaseDate: "2020-12-06T00:00:00Z")
        }
        
        struct Error  : Identifiable{
            var id : UUID = .init()
            var title : String
            var reason : String
            
            static let mock : Self = .init(title : "Oops", reason: "Some stuff happened")
        }
    }
}
