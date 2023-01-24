//
//  ItunesApiClient.swift
//  MyTunesRitage
//
//  Created by Ruben Mimoun on 23/01/2023.
//

import Foundation
import Combine

struct ItunesApiClient  : GetApiDelegate {

    typealias D = ItunesItemsRaw
    
    var apiClient : ApiClientDelegate
    
    init(apiClient : ApiClientDelegate =  APIClient()) {
        self.apiClient = apiClient
    }

    func get(_ query : String) -> AnyPublisher<ItunesItemsRaw, APIError> {
        let queried : [String : AnyHashable] = [
            "term"  : query.toSearchQueryFormat(),
            "entity":"podcast"
        ]
        return apiClient.fetch(query: queried.toQueryItems())
    }
}
