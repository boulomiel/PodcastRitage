//
//  ApiError.swift
//  MyTunesRitage
//
//  Created by Ruben Mimoun on 23/01/2023.
//

import Foundation

enum APIError : LocalizedError {
    case failedRequest(reason : String)
    case badURL(url : String)
    case httpError(status : Int)
    case parsingError(error : Error)
}
