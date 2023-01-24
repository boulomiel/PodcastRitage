//
//  File.swift
//  MyTunesRitage
//
//  Created by Ruben Mimoun on 24/01/2023.
//

import Foundation
import Combine

protocol ApiClientDelegate {
    func fetch<D : Codable>(query : [URLQueryItem]?) -> AnyPublisher<D,APIError>
}
