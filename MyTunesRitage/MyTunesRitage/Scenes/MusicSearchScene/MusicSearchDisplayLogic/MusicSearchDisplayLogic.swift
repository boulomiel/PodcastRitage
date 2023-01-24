//
//  MusicSearchDisplayLogic.swift
//  MyTunesRitage
//
//  Created by Ruben Mimoun on 23/01/2023.
//

import Foundation

protocol MusicSearchDisplayLogic : AnyObject {
    
    func showError(_ viewModel : MusicSearchData.ViewModel.Error)
    
    func showSong(_ viewModel : MusicSearchData.ViewModel.Song)
    
    func clearInput()
}


