//
//  MusicSearchBusinessLogic.swift
//  MyTunesRitage
//
//  Created by Ruben Mimoun on 23/01/2023.
//

import Foundation

protocol MusicSearchBusinessLogic {
    
    var presenter : MusicSearchPresenterLogic? { get set }
    
    var searchApi : ItunesApiClient { get set }
    
    func fetch( _ request :  MusicSearchData.Request)
}
