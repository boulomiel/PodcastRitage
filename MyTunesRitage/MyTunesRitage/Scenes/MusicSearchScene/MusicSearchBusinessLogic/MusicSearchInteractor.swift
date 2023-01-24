//
//  MusicSearchInteractor.swift
//  MyTunesRitage
//
//  Created by Ruben Mimoun on 23/01/2023.
//

import Foundation
import Combine

class MusicSearchInteractor : MusicSearchBusinessLogic {
        
    weak var presenter: MusicSearchPresenterLogic?
    
    var searchApi: ItunesApiClient
    
    var subscriptions : Set<AnyCancellable> = .init()
    
    init(searchApi : ItunesApiClient = ItunesApiClient()) {
        self.searchApi = searchApi
    }
    
    func fetch(_ request: MusicSearchData.Request) {
        let query = request.query
        presenter?.emptyResponse(.init())
        if query.isEmpty{
            clear()
            return
        }
       searchApi.get(query.toSearchQueryFormat())
            .first()
            .map { $0.results }
            .flatMap{ raws in
                raws
                .publisher
                .map{ MusicSearchData.Response.Success(raw: $0) }
                .eraseToAnyPublisher()
            }
            .flatMap(maxPublishers: .max(1)){
                Just($0)
                    .delay(for: 0.2, scheduler: DispatchQueue.main)
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion : { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.presenter?.showError(.init(raw: error))
                }
            } , receiveValue : {[weak self] item  in
                self?.presenter?.createSong(item)
            })
            .store(in:&subscriptions)
    }
    
    private func clear(){
        subscriptions.forEach{$0.cancel()}
    }
}
