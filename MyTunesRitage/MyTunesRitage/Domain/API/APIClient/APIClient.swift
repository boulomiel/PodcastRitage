//
//  APIClient.swift
//  MyTunesRitage
//
//  Created by Ruben Mimoun on 23/01/2023.
//

import Foundation
import Combine

struct APIClient : ApiClientDelegate {
    
    func fetch<D : Codable>(query : [URLQueryItem]? = nil) -> AnyPublisher<D,APIError> {
        var urlComponent =  URLComponents()
        urlComponent.scheme = ApiConstants.scheme
        urlComponent.host = ApiConstants.host
        urlComponent.path = ApiConstants.endpoint
        
        urlComponent.queryItems = query
        
        guard let url =  urlComponent.url else {
            return Fail(error: APIError.badURL(url: urlComponent.description))
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: URLRequest(url: url))
            .tryMap { data, response  in
                let status =  (response as! HTTPURLResponse).statusCode
                if status > 200 {
                    throw APIError.httpError(status: status)
                }
                let decoder =  JSONDecoder()
                do {
                    return try decoder.decode(D.self, from: data)
                } catch {
                    throw APIError.parsingError(error: error)
                }
            }
            .mapError { error -> APIError in
                return error as? APIError ?? APIError.failedRequest(reason: Texts.mapError)
            }
            .eraseToAnyPublisher()
    }
}
