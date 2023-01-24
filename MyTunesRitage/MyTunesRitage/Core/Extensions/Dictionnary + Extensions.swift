//
//  Dictionnary + Extensions.swift
//  MyTunesRitage
//
//  Created by Ruben Mimoun on 24/01/2023.
//

import Foundation

extension Dictionary where Key == String , Value == AnyHashable {
    func toQueryItems() -> [URLQueryItem] {
        return map { key, value in
            URLQueryItem(name: key, value: "\(value)")
        }
    }
}
