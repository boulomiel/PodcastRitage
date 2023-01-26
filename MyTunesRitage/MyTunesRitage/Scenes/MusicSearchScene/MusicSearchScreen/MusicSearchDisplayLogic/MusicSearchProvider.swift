//
//  MusicSearchProvider.swift
//  MyTunesRitage
//
//  Created by Ruben Mimoun on 23/01/2023.
//

import Foundation
import Combine

typealias Song = MusicSearchData.ViewModel.Song
typealias Failure = MusicSearchData.ViewModel.Error

class MusicSearchProvider : ObservableObject {
    
    var interactor : MusicSearchBusinessLogic? = MusicSearchInteractor()
    var presenter : MusicSearchPresenterLogic? = MusicSearchPresenter()
    var onClearInput : PassthroughSubject<(),Never> = .init()
    var onSongReceived : PassthroughSubject<Song,Never> = .init()
    var onErrorReceived : PassthroughSubject<Failure,Never> = .init()
    
    @Published var searchableText : String = ""
    var subscriptions : Set<AnyCancellable> = .init()
    
    func start() {
        interactor?.presenter = presenter
        presenter?.view = self
        observeInput()
    }
    
    func observeInput(){
        $searchableText
            .debounce(for: .seconds(0.3), scheduler: DispatchQueue.main, options: nil)
            .sink{[weak self] input in
                self?.interactor?.fetch(.init(query: input))
            }
            .store(in: &subscriptions)
    }
}

extension MusicSearchProvider : MusicSearchDisplayLogic {
    
    func clearInput() {
        self.onClearInput.send()
    }
    
    func showError(_ viewModel: MusicSearchData.ViewModel.Error) {
        self.onErrorReceived.send(viewModel)
    }
    
    func showSong(_ viewModel: MusicSearchData.ViewModel.Song) {
        self.onSongReceived.send(viewModel)
    }
    
}
