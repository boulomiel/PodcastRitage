//
//  MusicSearchPresenterLogic.swift
//  MyTunesRitage
//
//  Created by Ruben Mimoun on 23/01/2023.
//

import Foundation

protocol MusicSearchPresenterLogic : AnyObject {
    
    var view : MusicSearchDisplayLogic? { get set }
    
    func showError(_ response : MusicSearchData.Response.Error )
    
    func emptyResponse(_ response : MusicSearchData.Response.Empty)
    
    func createSong(_ response : MusicSearchData.Response.Success )
    
}
