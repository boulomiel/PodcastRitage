//
//  MusicSearchPresenter.swift
//  MyTunesRitage
//
//  Created by Ruben Mimoun on 23/01/2023.
//

import Foundation


class MusicSearchPresenter : MusicSearchPresenterLogic {

    weak var view: MusicSearchDisplayLogic?
    
    func showError(_ response: MusicSearchData.Response.Error) {
        let title = "Oops"
        switch response.raw {
        case .failedRequest(reason: let reason):
            view?.showError(.init(title: title, reason: reason))
        case .badURL(url: let url):
            view?.showError(.init(title: title, reason: "The url - \(url) is malformed"))
        case .httpError(status: let status):
            view?.showError(.init(title: title, reason: "The request failed with status \(status)"))
        case .parsingError(error: let error):
            view?.showError(.init(title: title, reason: "Data is not correctly parsed\nError: \n\(error)"))
        }
    }
    
    func createSong(_ response: MusicSearchData.Response.Success) {
        let item = response.raw
        guard let trackId = item.trackId,
              let artistName =  item.artistName,
              let trackName = item.trackName,
              let image = item.artworkUrl100,
              let releaseDate = item.releaseDate else {
            return
        }
        let song = MusicSearchData
            .ViewModel
            .Song(
                trackId: trackId ,
                artistName: artistName,
                trackName: trackName,
                image: image,
                releaseDate: releaseDate
            )
        view?.showSong(song)
    }
    
    func emptyResponse(_ response: MusicSearchData.Response.Empty) {
        view?.clearInput()
    }
}
