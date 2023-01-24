//
//  GetApiDelegate.swift
//  MyTunesRitage
//
//  Created by Ruben Mimoun on 23/01/2023.
//

import Foundation
import Combine

protocol GetApiDelegate {
    associatedtype D
    
    var apiClient : ApiClientDelegate {get set}
    
    func get(_ query : String) -> AnyPublisher<D, APIError>
}
